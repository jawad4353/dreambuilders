import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/location_adapter.dart';
part 'location_history_events.dart';
part 'location_history_state.dart';
/*
i am fetching users previous location history from hive box named locations and converting
it to Location object .Location is basically out adapter for hive its customized datatype
.and emitting list of this location model
 */
class LocationHistoryBloc extends Bloc<LocationHistoryEvent, LocationHistoryState> {
  List<Location> listHistory=[];
  LocationHistoryBloc() : super(LocationHistoryInitial()) {
    on<LocationHistoryEvent>((event, emit) async{
      if(event is LocationHistoryLoadEvent){
        try {
          listHistory.clear();
          final box = await Hive.openBox('locations');
          for (int i = 0; i < box.length; i++) {
            Location a=box.getAt(i) as Location;
            listHistory.add(box.getAt(i) as Location);
          }
          emit(LocationHistoryLoadedState(listHistory));
          await box.close();

        } catch (e) {
         emit(LocationHistoryErrorState(e.toString()));
        }

        }
      if(event is LocationHistoryClearEvent){
        emit(LocationHistoryInitial());
      }

    });
  }
}

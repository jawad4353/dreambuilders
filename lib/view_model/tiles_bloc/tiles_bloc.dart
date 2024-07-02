import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreambuilders/main.dart';
import 'package:dreambuilders/utilis/app_preferences.dart';
import 'package:equatable/equatable.dart';
import '../../utilis/suppoting_methods.dart';
part 'tiles._event.dart';
part 'tiles._state.dart';

class TilesBloc extends Bloc<TilesEvent, TilesState> {
  TilesBloc() : super(TilesInitialState()) {
    on<TilesEvent>((event, emit) async{
     try{
       if(event is TilesLoadingEvent){
         emit(TilesLoadingState());
         DocumentSnapshot<Map<String, dynamic>>  result=await FirebaseFirestore.instance.collection('prices').doc(preferences.getString(AppPrefs.keyEmail)).get();
         emit(TilesLoadedState(SupportingMethods.calculateTiles( event.lengthFloor,  event.widthFloor, event.lengthTile,event.widthTile,double.parse(result.data()!['tilesPrice']),event.wastePercentage,)));
       }}
    catch(e){
         emit(TilesErrorState(e.toString()));
    }

    });
  }
}

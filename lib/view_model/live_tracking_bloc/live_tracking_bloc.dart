import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../main.dart';
import '../../utilis/app_preferences.dart';
part 'live_tracking._event.dart';
part 'live_tracking._state.dart';
/*
tracing location of user continuously
 */
class LiveTrackingBloc extends Bloc<LiveTrackingEvent, LiveTrackingState> {
  Location _location=new Location();
  LiveTrackingBloc() : super(LiveTrackingInitial()) {
    on<LiveTrackingEvent>((event, emit) async{
      if(event is LiveTrackingLoadEvent){
        emit((LiveTrackingLoadedState(event.currentPosition)));
      }

      if(event is FetchLocationEvent){
        try{
          emit(const LiveTrackingLoadingState());
          LocationData data=await _location.getLocation();
          print('${data.latitude}'+'${data.longitude}');
          preferences.setDouble(AppPrefs.keyLatitude, data.latitude??0.0);
          preferences.setDouble(AppPrefs.keyLongitude, data.longitude??0.0);
          emit((LiveTrackingLoadedState(LatLng(data.latitude!, data.longitude!))));

        }catch(a){
          emit( LiveTrackingErrorState());
          EasyLoading.showInfo('Unable to fetch location. Try again !');
        }

      }
    });
  }




}

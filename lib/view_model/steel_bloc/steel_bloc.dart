import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreambuilders/main.dart';
import 'package:dreambuilders/utilis/app_preferences.dart';
import 'package:equatable/equatable.dart';
import '../../utilis/suppoting_methods.dart';
part 'steel._event.dart';
part 'steel._state.dart';


class SteelBloc extends Bloc<SteelEvent, SteelState> {
  SteelBloc() : super(SteelInitialState()) {
    on<SteelEvent>((event, emit) async{
     try{
       if(event is SteelLoadingEvent){
         emit(SteelLoadingState());
         DocumentSnapshot<Map<String, dynamic>>  result=await FirebaseFirestore.instance.collection('prices').doc(preferences.getString(AppPrefs.keyEmail)).get();
         emit(SteelLoadedState(SupportingMethods.calculateSteelCost(   
             length: event.length, width:  event.width, diameter: event.diameter, density: event.density, costPerKg: double.parse(result.data()!['steelPrice'],))));
       }}
    catch(e){
         emit(SteelErrorState(e.toString()));
    }

    });
  }
}

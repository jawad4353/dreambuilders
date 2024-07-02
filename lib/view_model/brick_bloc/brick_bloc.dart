import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreambuilders/main.dart';
import 'package:dreambuilders/utilis/app_preferences.dart';
import 'package:equatable/equatable.dart';
import '../../utilis/suppoting_methods.dart';
part 'brick_event.dart';
part 'brick._state.dart';

class BrickBloc extends Bloc<BrickEvent, BrickState> {
  BrickBloc() : super(BrickInitialState()) {
    on<BrickEvent>((event, emit) async{
     try{
       if(event is BrickLoadingEvent){
         emit(BrickLoadingState());
         DocumentSnapshot<Map<String, dynamic>>  result=await FirebaseFirestore.instance.collection('prices').doc(preferences.getString(AppPrefs.keyEmail)).get();
         emit(BrickLoadedState(SupportingMethods.calculateWallBricksRequired( event.length,  event.width, event.thickness,double.parse(result.data()!['brickPrice']),event.wastePercentage,)));
       }}
    catch(e){
         emit(BrickErrorState(e.toString()));
    }

    });
  }
}

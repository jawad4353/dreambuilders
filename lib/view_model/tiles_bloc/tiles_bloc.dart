import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
         DocumentSnapshot<Map<String, dynamic>>  result=await FirebaseFirestore.instance.collection('prices').doc('gkC0cqNnh8V29vHd0QVN').get();
         emit(TilesLoadedState(SupportingMethods.calculateTiles( event.lengthFloor,  event.widthFloor, event.lengthTile,event.widthTile,double.parse(result.data()!['tiles']),event.wastePercentage,)));
       }}
    catch(e){
         emit(TilesErrorState(e.toString()));
    }

    });
  }
}

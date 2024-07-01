import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../utilis/suppoting_methods.dart';
part 'cement._event.dart';
part 'cement._state.dart';

class CementBloc extends Bloc<CementEvent, CementState> {
  CementBloc() : super(CementInitialState()) {
    on<CementEvent>((event, emit) async{
     try{
       if(event is CementLoadingEvent){
         emit(CementLoadingState());
         DocumentSnapshot<Map<String, dynamic>>  result=await FirebaseFirestore.instance.collection('prices').doc('gkC0cqNnh8V29vHd0QVN').get();

         emit(CementLoadedState(SupportingMethods.calculatePlasterMaterials( event.length,  event.width, event.thickness,double.parse(result.data()!['cementBag'].toString()),double.parse(result.data()!['sandFourtyKG'].toString()))));
       }}
    catch(e){
         emit(CementErrorState(e.toString()));
    }

    });
  }
}

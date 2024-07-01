import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreambuilders/main.dart';
import 'package:dreambuilders/utilis/app_preferences.dart';
import 'package:equatable/equatable.dart';
part 'home._event.dart';
part 'home._state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) async{
     try{
       if(event is HomeLoadingEvent){
         emit(HomeLoadingState());
         DocumentSnapshot<Map<String, dynamic>>  result=await FirebaseFirestore.instance.collection('prices').doc(preferences.getString(AppPrefs.keyEmail)).get();
         emit(HomeLoadedState(result.data()??{}));
       }}
    catch(e){
         emit(HomeErrorState(e.toString()));
    }

    });
  }
}

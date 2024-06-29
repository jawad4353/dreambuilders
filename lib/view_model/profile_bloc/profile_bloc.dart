import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import '../../data/hive-helper.dart';
import '../../main.dart';
import '../../model/user_model.dart';
import '../../utilis/app_preferences.dart';
part 'profile_bloc_events.dart';
part 'profile_bloc_states.dart';

/*
using this bloc for profile screen .it will fetch the users data from firebase collection if
 any kind of error has occured then it will load data from hive if present
.Means we will be able to see profile screen offline after  it loaded once
 */
class ProfileBloc extends Bloc<ProfileEvent, ProfileStates> {
  bool isFirstEvent = true;
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) async{
      if(event is ProfileLoadEvent){
        if(isFirstEvent){emit(ProfileLoadingState());}
        isFirstEvent=false;
        try{
          DocumentSnapshot<Map<String, dynamic>> profileData= await FirebaseFirestore.instance.collection('users').doc(preferences.getString(AppPrefs.keyEmail)).get();
          if(profileData.exists){
            String encodedData=json.encode(profileData.data());
            Box ? box=await HiveHelper.openBox(name: 'users');
                   await box?.put('users', encodedData);
          emit(ProfileLoadedState(UserModel.fromJson(json.decode(encodedData))));
          }
          else{
            emit(ProfileErrorState());
          }

        }
        catch(e){
          Box ? box=await HiveHelper.openBox(name: 'users');
          if(box?.isNotEmpty??false){
            emit(ProfileLoadedState(UserModel.fromJson(json.decode(box!.values.toString()))));
            return;
          }
          else{
            emit(ProfileErrorState());
          }
          EasyLoading.showError(e.toString());
        }
      }

      if(event is ProfileClearEvent){
        emit(ProfileInitialState());
      }
    });
  }
}

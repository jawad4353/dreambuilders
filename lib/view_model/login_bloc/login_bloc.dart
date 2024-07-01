import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../network_config/firebase_service.dart';
import '../../utilis/app_preferences.dart';
import '../../utilis/app_routes.dart';
import '../../view/auth/login.dart';
import '../../view/bottom_screen.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
      if(event is LoginApiEvent){
        emit(LoginLoadingState());
      User? user=  await FirebaseAuthService.signInWithEmailAndPassword(email: event.email, password: event.password);
      if(user!=null){
        emit(LoginLodedState());
        preferences.setString(AppPrefs.keyEmail, user.email.toString());
        preferences.setString(AppPrefs.keyPassword, event.password);
        preferences.setString(AppPrefs.keyId, user.uid);
        preferences.setBool(AppPrefs.keyIsLogin, true);

        Navigator.pushReplacement(event.context, MyRoute(BottomScreen()));
      }
      else{
        emit(const LoginApiErrorState(''));
      }
      }


      if(event is ForgetPasswordEvent){
        emit(ForgotPasswordLoadingState());
        bool s=await FirebaseAuthService.resetPassword(event.email);
        if(s){
          emit(ForgotPasswordLoadedState());
          Navigator.pushReplacement(event.context, MyRoute(const Login()));
        }
        else{
          emit(ForgotPasswordErrorState());
        }
      }


    });
  }
}

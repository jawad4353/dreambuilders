import 'dart:async';
import 'package:dreambuilders/utilis/app_colors.dart';
import 'package:dreambuilders/utilis/app_images.dart';
import 'package:dreambuilders/utilis/app_preferences.dart';
import 'package:dreambuilders/utilis/app_routes.dart';
import 'package:dreambuilders/view/boarding/boarding.dart';
import 'package:dreambuilders/view/bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState(){
    customizeEasyLoading();
    super.initState();
    if(preferences.getBool(AppPrefs.keyIsLogin)==true){
      Timer(const Duration(seconds: 2,),()=>Navigator.pushReplacement(context, MyRoute(const BottomScreen())));
    }
    else{
      Timer(const Duration(seconds: 3,),()=>Navigator.pushReplacement(context, MyRoute(const BoardingScreen())));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.white,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.primary,AppColors.gradient],
                begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: Center(child: Image.asset(AppImages.imgLogoTransparent,height:1.sh*0.37 ),)),
    );
  }

  void customizeEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 49.0
      ..textStyle = TextStyle(height: 1.5, color: AppColors.white)
      ..radius = 10.0
      ..progressColor = AppColors.white
      ..backgroundColor = AppColors.primary
      ..indicatorColor = AppColors.white
      ..textColor = AppColors.white
      ..maskColor = AppColors.white.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = true;
  }
}

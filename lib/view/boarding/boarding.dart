import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';
import '../auth/login.dart';
import '../dialogues/location_permission_dialogue.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 1.sh * 0.98,
                  width: 1.sw,
                ),
                Positioned(top: 1.sh * 0.04, left: 0, right: 0, child: body()),
                Positioned(bottom: 35.h, left: 35.w, child: _btnSkip()),
                Positioned(bottom: 35.h, right: 35.w, child: _btnNext())
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Container(
        width: 1.sw * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Text(AppConstants.boardingTitle,
              style: AppTextStyles.robotoMedium(
                color: AppColors.white,
                fontSize: 24.sp,
                weight: FontWeight.w500,
              )),
          SizedBox(
            height: 30.h,
          ),
          Image.asset(AppImages.imgBoarding, height: 1.sh * 0.55),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              AppConstants.boardingSubtitle,
              style: AppTextStyles.robotoMedium(
                color: AppColors.white,
                fontSize: 17.sp,
                weight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ]));
  }

  Widget _btnSkip() {
    return InkWell(
      onTap: () {
        goToLogin();
      },
      child: Container(
        height: 60.h,
        width: 60.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: Image.asset(AppImages.iconSkip).image,
                fit: BoxFit.cover)),
        child: Center(
          child: Text(
            AppConstants.skip,
            style: AppTextStyles.robotoMedium(
              color: AppColors.primary,
              fontSize: 16.sp,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnNext() {
    return InkWell(
      onTap: () {
        goToLogin();
      },
      child: Container(
        height: 60.h,
        width: 60.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: Image.asset(AppImages.iconSkip).image,
                fit: BoxFit.cover)),
        child: Center(
          child: Text(
            AppConstants.next,
            style: AppTextStyles.robotoMedium(
              color: AppColors.primary,
              fontSize: 16.sp,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      AppSettings.openAppSettings();
    }
    return false;
  }

  goToLogin() async {
    bool result = await requestLocationPermission();
    if (result) {
      Navigator.pushReplacement(context, MyRoute(const Login()));
    } else {
      onLocationPermission(context);
    }
  }
}

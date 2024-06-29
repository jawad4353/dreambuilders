
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_text_styles.dart';
import '../widgets/custom_button.dart';

Future<bool> onExit(context) async {
  return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(AppConstants.areYouSureExit,
                      style: AppTextStyles.robotoMedium(
                        color: AppColors.black191B32,
                        fontSize: 19.sp,
                        weight: FontWeight.w400,
                      )),
                ),
                actions: [
                  SizedBox(
                      height: 35.h,
                      child: customDialogueButton(
                          title: AppConstants.exit,
                          onPressed: () => Navigator.of(context).pop(true))),
                  SizedBox(
                      height: 35.h,
                      child: customDialogueButton(
                          title: AppConstants.cancel,
                          onPressed: () => Navigator.of(context).pop(false))),
                ],
              ))) ??
      false;
}

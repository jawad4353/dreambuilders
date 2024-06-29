
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_text_styles.dart';
import '../widgets/custom_button.dart';

Future<bool> onLocationPermission(context) async {
  return (await showDialog(
          context: context,
          builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(AppConstants.locationRequired,
                          style: AppTextStyles.robotoMedium(
                            color: AppColors.black191B32,
                            fontSize: 19.sp,
                            weight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(AppConstants.appNeedsLocation,
                          style: AppTextStyles.robotoMedium(
                            color: AppColors.black191B32,
                            fontSize: 17.sp,
                            weight: FontWeight.w300,
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                          height: 35.h,
                          child: customDialogueButton(
                              title: AppConstants.ok,
                              onPressed: () =>
                                  Navigator.of(context).pop(false))),
                    ],
                  ),
                ),
              ))) ??
      false;
}

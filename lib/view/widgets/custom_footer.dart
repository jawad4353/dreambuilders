
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Widget customFooter({required String title,required String clickableText,required VoidCallback callback}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: AppTextStyles.robotoMedium(
          color: AppColors.black191B32,
          fontSize: 14.sp,
          weight: FontWeight.w500,
        ),
      ),
      InkWell(
        onTap: callback,
        child: Text(
          clickableText,
          style: AppTextStyles.robotoMedium(
            color: AppColors.primary,
            fontSize: 16.sp,
            weight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

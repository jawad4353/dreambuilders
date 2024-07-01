import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Widget customButton({
  required String title,
  required VoidCallback onPressed,
  bool disabled = false,
  bool fullLength=true,
}) {
  return SizedBox(
    height: 48.h,
    width: fullLength ?1.sw :1.sw*0.42,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled ? AppColors.grey0E0F10 : AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        title,
        style: AppTextStyles.robotoBold(
          color: disabled ? AppColors.white.withOpacity(0.5) : AppColors.white,
          fontSize: 16.sp,
          weight: FontWeight.w600,
        ),
      ),
    ),
  );
}



Widget customDialogueButton( {required String title,
  required VoidCallback onPressed}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
    ),
    onPressed:onPressed,
    child:   Text(title,style:AppTextStyles.robotoMedium(
      color: AppColors.white,
      fontSize: 14.sp,
      weight: FontWeight.w400,
    )),
  );
}
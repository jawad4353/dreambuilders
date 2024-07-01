import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Widget customCalculatorField({
  required TextEditingController controller,
  required String hintText,
  required String title,
  TextInputType? keyboardType,
  TextInputFormatter? inputFormatter,
}) {
  return Container(
    height: 60.h,
    width: 1.sw,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7.r),
      border: Border.all(color: AppColors.greyB2AFAF, width: 1.1),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
          child:  VerticalDivider(width: 1.2.w),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 6.h),
                child: Text(
                  title,
                  style: AppTextStyles.robotoMedium(
                    color: AppColors.grey0E0F10,
                    fontSize: 14.sp,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
                // Remove the width property
                child:TextField(
                  onChanged: (a) {},
                  controller: controller,
                  keyboardType: keyboardType,
                  cursorColor: AppColors.primary,
                  cursorWidth: 3,
                  cursorHeight: 16,
                  inputFormatters: inputFormatter != null ? [inputFormatter] : null,
                  style: AppTextStyles.robotoMedium(
                    color: AppColors.black191B32,
                    fontSize: 14.sp,
                    weight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 12.h),
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

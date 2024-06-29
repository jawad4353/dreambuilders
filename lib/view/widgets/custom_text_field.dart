import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_text_styles.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  required String title,
  required String icon,
  required bool isPasswordField,
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
        Container(
          height: 37.h,
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          child: Image.asset(icon, color: AppColors.primary),
        ),
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
                child: isPasswordField
                    ? PasswordTextField(
                  controller: controller,
                  hintText: hintText,
                  inputFormatter: inputFormatter,
                )
                    : TextField(
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

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputFormatter? inputFormatter;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.inputFormatter,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (a) {},
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: AppColors.primary,
      cursorWidth: 3.w,
      cursorHeight: 16.h,
      obscureText: hidePassword,
      inputFormatters: widget.inputFormatter != null ? [widget.inputFormatter!] : null,
      style: AppTextStyles.robotoMedium(
        color: AppColors.black191B32,
        fontSize: 14.sp,
        weight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          child: Image.asset(
            hidePassword
                ? AppImages.iconVisibility
                : AppImages.iconVisibilityOff,
            color: AppColors.primary,
            height: 50,
            width: 50,
          ),
        ),
        contentPadding: EdgeInsets.only(bottom: 12.h),
        hintText: widget.hintText,
      ),
    );
  }
}

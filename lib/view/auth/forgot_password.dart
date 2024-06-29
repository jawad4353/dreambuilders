
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_text_styles.dart';
import '../../view_model/login_bloc/login_bloc.dart';
import '../widgets/auth_screens_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 1.sh * 0.95,
                    width: 1.sw,
                    color: AppColors.white,
                  ),
                  header(),
                  Positioned(
                    top: 36.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.forgetPassword,
                          style: AppTextStyles.robotoBold(
                              color: AppColors.white,
                              fontSize: 30.sp,
                              weight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          AppConstants.enterEmail,
                          style: AppTextStyles.robotoMedium(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              weight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 1.sh * 0.28, left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        customTextField(
                            title: AppConstants.email,
                            hintText: AppConstants.emailHint,
                            controller: emailController,
                            icon: AppImages.iconEmail,
                            isPasswordField: false,
                            inputFormatter: AppConstants.emailFormatter),
                        SizedBox(
                          height: 20.h,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          if (state is ForgotPasswordLoadingState) {
                            return customButton(
                                title: AppConstants.getLink,
                                onPressed: () {},
                                disabled: true);
                          }
                          return customButton(
                              title: AppConstants.getLink,
                              onPressed: () {
                                if (emailController.text
                                    .replaceAll(' ', '')
                                    .isEmpty) {
                                  EasyLoading.showInfo('Enter email');
                                  return;
                                }
                                context.read<LoginBloc>().add(
                                    ForgetPasswordEvent(
                                        emailController.text, context));
                              });
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

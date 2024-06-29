
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_text_styles.dart';
import '../../widgets/custom_appbar.dart';

class ImageDisplayScreen extends StatelessWidget {
  final String? imageUrl;
  final String userName;

  const ImageDisplayScreen(
      {super.key, required this.imageUrl, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0.h),
          child: myAppBar(
              title: AppConstants.viewImage,
              context: context,
              shouldPop: true)),
      body: Center(
        child: imageUrl == null
            ? CircleAvatar(
                radius: 50.r,
                backgroundColor: AppColors.primary,
                child: Text(
                  userName[0].toUpperCase(),
                  style: AppTextStyles.robotoMedium(
                      color: AppColors.primary,
                      fontSize: 23.sp,
                      weight: FontWeight.w400),
                ),
              )
            : Image.network(imageUrl ?? ''),
      ),
    );
  }
}

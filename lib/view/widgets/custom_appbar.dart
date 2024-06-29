import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Widget myAppBar({required String title,required BuildContext context,required bool shouldPop}){
  return   AppBar(
    automaticallyImplyLeading: shouldPop,
  leading:shouldPop? InkWell(
  onTap: (){
  Navigator.of(context).pop();
  },
  child: Container(
  height: 35.h,
  width: 35.h,
  margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.h),
  clipBehavior: Clip.antiAlias,
  decoration:  BoxDecoration(
  color: AppColors.white,
  shape: BoxShape.circle
  ),
  child: Center(child: Icon(Icons.arrow_back_ios_outlined,color: AppColors.primary,size: 23.h,)),
  ),
  ):null,
  backgroundColor:AppColors.primary ,
  centerTitle: true,
  title:  Text(title,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 24.sp, weight: FontWeight.w600),),);

}
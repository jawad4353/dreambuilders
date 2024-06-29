import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_images.dart';

Widget header(){
  return ClipPath(
    clipper: ProsteBezierCurve(
      position: ClipPosition.bottom,
      list: [
        BezierCurveSection(
          start: const Offset(0, 166),
          top: Offset(1.sw / 4, 190),
          end: Offset(1.sw  / 2, 155),
        ),
        BezierCurveSection(
          start: Offset(1.sw  / 2, 25),
          top: Offset(1.sw / 4 * 3, 100),
          end: Offset(1.sw , 150),
        ),
      ],
    ),
    child: Container(
      height: 1.sh *0.3,
      width: 1.sw ,
      color: AppColors.primary,
      child:  Opacity(opacity: 0.3,
        child: Image.asset(AppImages.imgPattern,fit: BoxFit.cover,color: AppColors.white,),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'app_fonts.dart';

class AppTextStyles{

  static robotoRegular({required Color color,required fontSize,required FontWeight weight,}){
return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily:AppFontFamilies.robotoRegular );
}

  static robotoBold({required Color color,required fontSize,required FontWeight weight,}){
    return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily: AppFontFamilies.robotoBold);
  }

  static robotoBoldItalic({required Color color,required fontSize,required FontWeight weight,}){
    return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily: AppFontFamilies.robotoBoldItalic);
  }

  static robotoThin({required Color color,required fontSize,required FontWeight weight,}){
    return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily: AppFontFamilies.robotoThin);
  }

  static robotoMedium({required Color color,required fontSize,required FontWeight weight,}){
    return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily: AppFontFamilies.robotoMedium);
  }

}
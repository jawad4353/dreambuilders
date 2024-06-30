import 'package:dreambuilders/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_constants.dart';

class CementCalculator extends StatefulWidget {
  const CementCalculator({super.key});

  @override
  State<CementCalculator> createState() => _CementCalculatorState();
}

class _CementCalculatorState extends State<CementCalculator> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: AppConstants.cement+" "+AppConstants.calculator, context: context, shouldPop: false)),
    );
  }
}

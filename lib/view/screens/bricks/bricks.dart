import 'package:dreambuilders/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_constants.dart';

class BricksCalculator extends StatefulWidget {
  const BricksCalculator({super.key});

  @override
  State<BricksCalculator> createState() => _BricksCalculatorState();
}

class _BricksCalculatorState extends State<BricksCalculator> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: AppConstants.bricks+" "+AppConstants.calculator, context: context, shouldPop: false)),
    );
  }
}

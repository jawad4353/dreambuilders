import 'package:dreambuilders/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_constants.dart';

class TilesCalculator extends StatefulWidget {
  const TilesCalculator({super.key});

  @override
  State<TilesCalculator> createState() => _TilesCalculatorState();
}

class _TilesCalculatorState extends State<TilesCalculator> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: AppConstants.tiles+" "+AppConstants.calculator, context: context, shouldPop: false)),
    );
  }
}

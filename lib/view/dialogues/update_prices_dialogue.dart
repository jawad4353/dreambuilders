import 'package:dreambuilders/utilis/app_text_styles.dart';
import 'package:dreambuilders/view/widgets/custom_button.dart';
import 'package:dreambuilders/view/widgets/custom_calculator_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';

class PriceUpdateDialog extends StatefulWidget {
  final String initialSteelPrice;
  final String initialTilePrice;
  final String initialCementBagPrice;
  final String initialBrickPrice;

  PriceUpdateDialog({
    required this.initialSteelPrice,
    required this.initialTilePrice,
    required this.initialCementBagPrice,
    required this.initialBrickPrice,
  });

  @override
  _PriceUpdateDialogState createState() => _PriceUpdateDialogState();
}

class _PriceUpdateDialogState extends State<PriceUpdateDialog> {
  late TextEditingController steelPriceController;
  late TextEditingController tilePriceController;
  late TextEditingController cementBagPriceController;
  late TextEditingController brickPriceController;

  @override
  void initState() {
    super.initState();
    steelPriceController = TextEditingController(text: widget.initialSteelPrice.toString());
    tilePriceController = TextEditingController(text: widget.initialTilePrice.toString());
    cementBagPriceController = TextEditingController(text: widget.initialCementBagPrice.toString());
    brickPriceController = TextEditingController(text: widget.initialBrickPrice.toString());
  }

  @override
  void dispose() {
    steelPriceController.dispose();
    tilePriceController.dispose();
    cementBagPriceController.dispose();
    brickPriceController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20.h,),
            Text('Update Prices',style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 17.sp, weight: FontWeight.w500),),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: tilePriceController, hintText: '10 ', title: 'Tile Price (per cm)'),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: brickPriceController, hintText: '15 ', title: 'One Brick Price'),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: cementBagPriceController, hintText: '120 ', title: 'Cement Bag Price'),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: steelPriceController, hintText: '120 ', title: 'Steel Price (per kg)')
            ,SizedBox(height: 10.h,),
             customButton(fullLength: false,title: 'Update', onPressed: (){

            }),
            SizedBox(height: 20.h,),
          ],
        ),
      ),

    );
  }
}
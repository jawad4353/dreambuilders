import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreambuilders/main.dart';
import 'package:dreambuilders/utilis/app_constants.dart';
import 'package:dreambuilders/utilis/app_preferences.dart';
import 'package:dreambuilders/utilis/app_text_styles.dart';
import 'package:dreambuilders/view/widgets/custom_button.dart';
import 'package:dreambuilders/view/widgets/custom_calculator_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/suppoting_methods.dart';
import '../../view_model/home_bloc/home_bloc.dart';

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
            customCalculatorField(controller: tilePriceController, hintText: '10 ', title: 'Tile Price (per cm)',inputFormatter: AppConstants.longitudeLatitudeFormatter),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: brickPriceController, hintText: '15 ', title: 'One Brick Price',inputFormatter: AppConstants.longitudeLatitudeFormatter),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: cementBagPriceController, hintText: '120 ', title: 'Cement Bag Price',inputFormatter: AppConstants.longitudeLatitudeFormatter),
            SizedBox(height: 10.h,),
            customCalculatorField(controller: steelPriceController, hintText: '120 ', title: 'Steel Price (per kg)',inputFormatter: AppConstants.longitudeLatitudeFormatter)
            ,SizedBox(height: 10.h,),
             customButton(fullLength: false,title: 'Update', onPressed: () async {
                  if(tilePriceController.text.isEmpty){
                    EasyLoading.showInfo('Tile price cannot be empty !');
                    return;
                  }
                  if(SupportingMethods.containsNoDigits(tilePriceController.text)){
                    EasyLoading.showInfo('Tile price should contain digit!');
                    return;
                  }
                  if(brickPriceController.text.isEmpty){
                    EasyLoading.showInfo('Brick price cannot be empty !');
                    return;
                  }
                  if(SupportingMethods.containsNoDigits(brickPriceController.text)){
                    EasyLoading.showInfo('Brick price should contain digit!');
                    return;
                  }
                  if(cementBagPriceController.text.isEmpty){
                    EasyLoading.showInfo('Cement Bag price cannot be empty !');
                    return;
                  }
                  if(SupportingMethods.containsNoDigits(cementBagPriceController.text)){
                    EasyLoading.showInfo('Cement price should contain digit!');
                    return;
                  }
                  if(steelPriceController.text.isEmpty){
                    EasyLoading.showInfo('Steel price cannot be empty !');
                    return;
                  }
                  if(SupportingMethods.containsNoDigits(steelPriceController.text)){
                    EasyLoading.showInfo('Steel price should contain digit!');
                    return;
                  }
                  bool result=await updatePrice();
                  if(result){Navigator.of(context).pop();}
            }),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }


  Future<bool> updatePrice() async {
   try{
     EasyLoading.show();
     await FirebaseFirestore.instance.collection('prices').doc(preferences.getString(AppPrefs.keyEmail)).
     update({'steelPrice':steelPriceController.text,'brickPrice':brickPriceController.text,'cementBag':
     cementBagPriceController.text,'tilesPrice':tilePriceController.text});
     context.read<HomeBloc>().add(const HomeLoadingEvent());
     return true;
   }
   catch(e){
     EasyLoading.showInfo(e.toString().split(']')[0]);
   }
   finally{EasyLoading.dismiss();}
    return false;
  }
}
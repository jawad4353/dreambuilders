import 'package:dreambuilders/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/suppoting_methods.dart';
import '../../../view_model/brick_bloc/brick_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_calculator_field.dart';

class BrickWallCalculator extends StatefulWidget {
  const BrickWallCalculator({super.key});

  @override
  State<BrickWallCalculator> createState() => _BrickWallCalculatorState();
}

class _BrickWallCalculatorState extends State<BrickWallCalculator> {
  TextEditingController length= TextEditingController();
  TextEditingController width= TextEditingController();
  TextEditingController thickness= TextEditingController();
  TextEditingController wastePercentage= TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: "${AppConstants.bricks} ${AppConstants.calculator}", context: context, shouldPop: true)),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(children: [
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCalculatorField(title:'${AppConstants.length}${AppConstants.ofWall}' ,controller: length,hintText: AppConstants.hintLength,inputFormatter: AppConstants.longitudeLatitudeFormatter),
              SizedBox(height: 10.h,),
              customCalculatorField(title:'${AppConstants.width}${AppConstants.ofWall}' ,controller: width,hintText: AppConstants.hintWidth,inputFormatter: AppConstants.longitudeLatitudeFormatter),
            ],),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCalculatorField(title:'${AppConstants.thickness}${AppConstants.ofWall}' ,controller: thickness,hintText: AppConstants.hintThickness,inputFormatter: AppConstants.longitudeLatitudeFormatter),
              SizedBox(height: 10.h,),
              customCalculatorField(title:'${AppConstants.wastePercent} ${AppConstants.bricks}' ,controller: wastePercentage,hintText: AppConstants.hintWaste,inputFormatter: AppConstants.longitudeLatitudeFormatter),
            ],)
          ,
          SizedBox(height: 10.h,),
          button(),

          Container(
            height: 700,
            child: BlocBuilder<BrickBloc,BrickState>(builder: (context,state){
              if(state is BrickInitialState){return const SizedBox();}
              if(state is BrickLoadingState ){
                return Center(child:  CircularProgressIndicator(color: AppColors.primary,));
              }
              if(state is BrickLoadedState){
                return BrickDataTable( data: state.result,);
              }
              if(state is BrickErrorState){
                return Text(state.error);
              }
              return const SizedBox();
            }),
          ),
        ],),
      ),

    );
  }

  Widget button(){
    return  customButton(fullLength: false,title: AppConstants.calculate, onPressed: (){
      if(length.text.isEmpty){
        EasyLoading.showInfo('Length required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(length.text)){
        EasyLoading.showInfo('Enter any digit in  length !');
        return;
      }
      if(width.text.isEmpty){
        EasyLoading.showInfo('Width required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(width.text)){
        EasyLoading.showInfo('Enter any digit in  width !');
        return;
      }
      if(thickness.text.isEmpty){
        EasyLoading.showInfo('Thickness of wall required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(thickness.text)){
        EasyLoading.showInfo('Enter any digit in thickness !');
        return ;}
      if(wastePercentage.text.isEmpty){
        EasyLoading.showInfo('Waste percentage required !');
        return;
      }

      context.read<BrickBloc>().add(BrickLoadingEvent(double.parse(length.text),double.parse(width.text),double.parse(thickness.text),double.parse(wastePercentage.text)));
    });
  }
}

class BrickDataTable extends StatelessWidget {
  final Map<String, dynamic> data;

  BrickDataTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: 1.sh*0.67,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Unit')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Total Area')),
                DataCell(Text(data['totalArea'].toStringAsFixed(2))),
                DataCell(Text('sq meters')),
              ]),
              DataRow(cells: [
                DataCell(Text('Total Bricks')),
                DataCell(Text(data['totalBricks'].toString())),
                DataCell(Text('bricks')),
              ]),
              DataRow(cells: [
                DataCell(Text('Wasted Bricks')),
                DataCell(Text(data['wastedBricks'].toString())),
                DataCell(Text('bricks')),
              ]),
              DataRow(cells: [
                DataCell(Text('Total Cost')),
                DataCell(Text(data['totalCost'].toStringAsFixed(2))),
                DataCell(Text('currency')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
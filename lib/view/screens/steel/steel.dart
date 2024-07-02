import 'package:dreambuilders/view/widgets/custom_appbar.dart';
import 'package:dreambuilders/view_model/steel_bloc/steel_bloc.dart';
import 'package:dreambuilders/view_model/tiles_bloc/tiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/suppoting_methods.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_calculator_field.dart';

class SteelCalculator extends StatefulWidget {
  const SteelCalculator({super.key});

  @override
  State<SteelCalculator> createState() => _SteelCalculatorState();
}

class _SteelCalculatorState extends State<SteelCalculator> {
  TextEditingController length= TextEditingController();
  TextEditingController width= TextEditingController();
  TextEditingController diameter= TextEditingController();
  TextEditingController density= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: "${AppConstants.steel} ${AppConstants.calculator}", context: context, shouldPop: false)),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(children: [
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCalculatorField(title:AppConstants.length +AppConstants.ofArea,controller: length,hintText: AppConstants.hintLength,inputFormatter: AppConstants.longitudeLatitudeFormatter),
              SizedBox(height: 10.h,),
              customCalculatorField(title:'${AppConstants.width}${AppConstants.ofArea}' ,controller: width,hintText: AppConstants.hintWidth,inputFormatter: AppConstants.longitudeLatitudeFormatter),
            ],),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCalculatorField(title:AppConstants.diameter+AppConstants.ofArea ,controller: diameter,hintText: AppConstants.diameterHint,inputFormatter: AppConstants.longitudeLatitudeFormatter),
              SizedBox(height: 10.h,),
              customCalculatorField(title:'${AppConstants.density}${AppConstants.ofSteel}' ,controller: density,hintText: AppConstants.densityHint,inputFormatter: AppConstants.longitudeLatitudeFormatter),
            ],)
          ,
          SizedBox(height: 10.h,),
          button(),
          SizedBox(height: 10.h,),
          BlocBuilder<SteelBloc,SteelState>(builder: (context,state){
            if(state is SteelInitialState){return const SizedBox();}
            if(state is SteelLoadingState ){
              return Center(child:  CircularProgressIndicator(color: AppColors.primary,));
            }
            if(state is SteelLoadedState){
              return DataTableDisplay(dataMap: state.result,);
            }
            if(state is SteelErrorState){
              return Text(state.error);
            }
            return const SizedBox();
          }),
        ],),
      ),

    );
  }

  Widget button(){
    return  customButton(fullLength: true,title: AppConstants.calculate, onPressed: (){
      if(length.text.isEmpty){
        EasyLoading.showInfo('Length required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(length.text)){
        EasyLoading.showInfo('Enter any digit in floor length !');
        return;
      }
      if(width.text.isEmpty){
        EasyLoading.showInfo('Width required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(width.text)){
        EasyLoading.showInfo('Enter any digit in floor width !');
        return;
      }
      if(diameter.text.isEmpty){
        EasyLoading.showInfo('Diameter  required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(diameter.text)){
        EasyLoading.showInfo('Enter any digit in diameter !');
        return ;}
      if(density.text.isEmpty){
        EasyLoading.showInfo('Density of steel required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(density.text)){
        EasyLoading.showInfo('Enter any digit in density of steel !');
        return ;}
      context.read<SteelBloc>().add(SteelLoadingEvent(double.parse(length.text),double.parse(width.text),double.parse(diameter.text),double.parse(density.text)));
    });
  }
}


class DataTableDisplay extends StatelessWidget {
  final Map<String, dynamic> dataMap;

  DataTableDisplay({Key? key, required this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Property')),
        DataColumn(label: Text('Value')),
        DataColumn(label: Text('Unit')),
      ],
      rows: dataMap.entries.map((entry) {
        String property = entry.key;
        dynamic value = entry.value;
        String unit = getUnit(property); // Function to get unit based on property

        return DataRow(cells: [
          DataCell(Text(property)),
          DataCell(Text(value.toString())),
          DataCell(Text(unit)),
        ]);
      }).toList(),
    );
  }

  String getUnit(String property) {
    switch (property) {
      case 'cost':
        return '\$';
      case 'steelAmount':
        return 'm³';
      case 'totalArea':
        return 'm²';
      case 'totalDensity':
        return 'kg';
      case 'totalDiameter':
        return 'm³';
      default:
        return '';
    }
  }
}
import 'package:dreambuilders/utilis/suppoting_methods.dart';
import 'package:dreambuilders/view/widgets/custom_appbar.dart';
import 'package:dreambuilders/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../view_model/cement_bloc/cement_bloc.dart';
import '../../widgets/custom_calculator_field.dart';

class CementCalculator extends StatefulWidget {
  const CementCalculator({super.key});

  @override
  State<CementCalculator> createState() => _CementCalculatorState();
}

class _CementCalculatorState extends State<CementCalculator> {
  TextEditingController lengthOfWall= TextEditingController();
  TextEditingController widthOfWall= TextEditingController();
  TextEditingController thicknessOfWall= TextEditingController();
  Map<String,dynamic> result={};
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: AppConstants.cement+" "+AppConstants.calculator, context: context, shouldPop: false)),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(children: [
          SizedBox(height: 10.h,),
        customCalculatorField(title:'${AppConstants.length}${AppConstants.ofWall}' ,controller: lengthOfWall,hintText: AppConstants.hintLength,inputFormatter: AppConstants.longitudeLatitudeFormatter),
          SizedBox(height: 10.h,),
          customCalculatorField(title:'${AppConstants.width}${AppConstants.ofWall}' ,controller: widthOfWall,hintText: AppConstants.hintWidth,inputFormatter: AppConstants.longitudeLatitudeFormatter),
          SizedBox(height: 10.h,),
         customCalculatorField(title:'${AppConstants.thickness}${AppConstants.ofWall}' ,controller: thicknessOfWall,hintText: AppConstants.hintThickness,inputFormatter: AppConstants.longitudeLatitudeFormatter),
          SizedBox(height: 10.h,),
          customButton(title: AppConstants.calculate, onPressed: (){
            if(lengthOfWall.text.isEmpty){
              EasyLoading.showInfo('Length required !');
              return;
            }
            if(SupportingMethods.containsNoDigits(lengthOfWall.text)){
              EasyLoading.showInfo('Enter any digit in length !');
              return;
            }
            if(widthOfWall.text.isEmpty){
              EasyLoading.showInfo('Width required !');
              return;
            }
            if(SupportingMethods.containsNoDigits(widthOfWall.text)){
              EasyLoading.showInfo('Enter any digit in width !');
              return;
            }
            if(thicknessOfWall.text.isEmpty){
              EasyLoading.showInfo('Thickness required !');
              return;
            }
            if(SupportingMethods.containsNoDigits(thicknessOfWall.text)){
              EasyLoading.showInfo('Enter any digit in thickness !');
              return ;}
            context.read<CementBloc>().add(CementLoadingEvent(double.parse(lengthOfWall.text),double.parse(widthOfWall.text),double.parse(thicknessOfWall.text)));
          }),


          BlocBuilder<CementBloc,CementState>(builder: (context,state){
            if(state is CementInitialState){return const SizedBox();}
            if(state is CementLoadingState ){
              return Center(child:  CircularProgressIndicator(color: AppColors.primary,));
            }
            if(state is CementLoadedState){
              return PlasterMaterialsTable(data: state.result,);
            }
            if(state is CementErrorState){
              return Text(state.error);
            }
           return const SizedBox();
          }),
        ],),
      ),

    );
  }
}

class PlasterMaterialsTable extends StatelessWidget {
  final Map<String, dynamic> data;

  PlasterMaterialsTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Material',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Quantity',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Unit',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Total Area')),
              DataCell(Text(data['totalArea'].toString())),
              DataCell(Text('m²')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Cement Bags Required')),
              DataCell(Text(data['cementBags'].toString())),
              DataCell(Text('bags')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Sand Required')),
              DataCell(Text(data['sandRequired'].toString())),
              DataCell(Text('m³')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Total Cost')),
              DataCell(Text(data['totalCost'].toString())),
              DataCell(Text('Rs')),
            ],
          ),
        ],
      ),
    );
  }
}
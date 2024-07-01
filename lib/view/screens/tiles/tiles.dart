import 'package:dreambuilders/view/widgets/custom_appbar.dart';
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

class TilesCalculator extends StatefulWidget {
  const TilesCalculator({super.key});

  @override
  State<TilesCalculator> createState() => _TilesCalculatorState();
}

class _TilesCalculatorState extends State<TilesCalculator> {
  TextEditingController lengthOfFloor= TextEditingController();
  TextEditingController widthOfFloor= TextEditingController();
  TextEditingController lengthOfTile= TextEditingController();
  TextEditingController widthOfTile= TextEditingController();
  TextEditingController wastePercentage= TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(59.h),
          child: myAppBar(title: AppConstants.tiles+" "+AppConstants.calculator, context: context, shouldPop: false)),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(children: [
          SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          customCalculatorField(title:'${AppConstants.length}${AppConstants.ofFloor}' ,controller: lengthOfFloor,hintText: AppConstants.hintLength,inputFormatter: AppConstants.longitudeLatitudeFormatter),
          SizedBox(height: 10.h,),
          customCalculatorField(title:'${AppConstants.width}${AppConstants.ofFloor}' ,controller: widthOfFloor,hintText: AppConstants.hintWidth,inputFormatter: AppConstants.longitudeLatitudeFormatter),
        ],),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            customCalculatorField(title:'${AppConstants.length}${AppConstants.ofTile}' ,controller: lengthOfTile,hintText: AppConstants.hintTile,inputFormatter: AppConstants.longitudeLatitudeFormatter),
            SizedBox(height: 10.h,),
            customCalculatorField(title:'${AppConstants.width}${AppConstants.ofTile}' ,controller: widthOfTile,hintText: AppConstants.hintTile,inputFormatter: AppConstants.longitudeLatitudeFormatter),
          ],)
         ,
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCalculatorField(title:AppConstants.wastePercent ,controller: wastePercentage,hintText: AppConstants.hintWaste,inputFormatter: AppConstants.longitudeLatitudeFormatter),
              SizedBox(height: 10.h,),
              button(),
            ],),


          BlocBuilder<TilesBloc,TilesState>(builder: (context,state){
            if(state is TilesInitialState){return const SizedBox();}
            if(state is TilesLoadingState ){
              return Center(child:  CircularProgressIndicator(color: AppColors.primary,));
            }
            if(state is TilesLoadedState){
              return TileCalculationTable(result: state.result,);
            }
            if(state is TilesErrorState){
              return Text(state.error);
            }
            return const SizedBox();
          }),
        ],),
      ),

    );
  }

  Widget button(){
    return  customButton(fullLength: false,title: AppConstants.calculate, onPressed: (){
      if(lengthOfFloor.text.isEmpty){
        EasyLoading.showInfo('Length required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(lengthOfFloor.text)){
        EasyLoading.showInfo('Enter any digit in floor length !');
        return;
      }
      if(widthOfFloor.text.isEmpty){
        EasyLoading.showInfo('Width required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(widthOfFloor.text)){
        EasyLoading.showInfo('Enter any digit in floor width !');
        return;
      }
      if(lengthOfTile.text.isEmpty){
        EasyLoading.showInfo('Tile length required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(lengthOfTile.text)){
        EasyLoading.showInfo('Enter any digit in Tile length !');
        return ;}
      if(widthOfTile.text.isEmpty){
        EasyLoading.showInfo('Tile width required !');
        return;
      }
      if(SupportingMethods.containsNoDigits(widthOfTile.text)){
        EasyLoading.showInfo('Enter any digit in Tile width !');
        return ;}
      context.read<TilesBloc>().add(TilesLoadingEvent(double.parse(lengthOfFloor.text),double.parse(widthOfFloor.text),double.parse(lengthOfTile.text),double.parse(widthOfTile.text),double.parse(wastePercentage.text)));
    });
  }
}
class TileCalculationTable extends StatelessWidget {
  final Map<String, dynamic> result;
  TileCalculationTable({required this.result});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[

        DataColumn(
          label: Text(
            'Item Name',
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
            const DataCell(Text('tiles')), // Unit
            const DataCell(Text('Tiles Required')), // Item Name
            DataCell(Text(result['tilesRequired'].toString())), // Quantity
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Rs')), // Unit
            const DataCell(Text('Total Cost')), // Item Name
            DataCell(Text(result['totalCost'].toString())), // Quantity
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('m²')), // Unit
            const DataCell(Text('Total Area')), // Item Name
            DataCell(Text(result['totalArea'].toStringAsFixed(2))), // Quantity
          ],
        ),
      ],
    );
  }
}
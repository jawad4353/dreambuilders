
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_images.dart';
import '../../../view_model/draw_polyline_bloc/draw_polyline_bloc.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
/*
Initially i am adding destination null in  FetchLocationEvent so initially no
polyline will be created .on entering latitude and longitude i am passing LatLng object having values of
destination .So then the emitted state will give us polylines list from our current location to destination location
 */
class DrawPolyLine extends StatefulWidget {
  const DrawPolyLine({super.key});

  @override
  State<DrawPolyLine> createState() => _DrawPolyLineState();
}

class _DrawPolyLineState extends State<DrawPolyLine> {
  TextEditingController destinationLatitude = TextEditingController();
  TextEditingController destinationLongitude = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DrawPolyLineBloc>().add(const FetchLocationEvent(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: myAppBar(
              title: AppConstants.drawPolyline,
              context: context,
              shouldPop: false)),
      body: Stack(
        children: [
          SizedBox(
            height: 1.sh,
          ),
          BlocBuilder<DrawPolyLineBloc, DrawPolyLineState>(
            builder: (context, state) {
              if (state is DrawPolyLineLoadedState) {
                return googleMap(currentPosition: state.currentPosition, markers: state.markers, polylines: state.polylines);
              } else if (state is DrawPolyLineErrorState) {
                return Center(child: Text(state.message));
              }
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            },
          ),
          Positioned(
            top: 10.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.sw*0.2),
              color: AppColors.white,
              child: Column(
                children: [
                  customTextField(
                      controller: destinationLatitude,
                      hintText: AppConstants.latitudeHint,
                      title: AppConstants.latitude,
                      icon: AppImages.longitudeLatitudeIcon,
                      isPasswordField: false,
                      inputFormatter: AppConstants.longitudeLatitudeFormatter),
                  SizedBox(height: 5.h,),
                  customTextField(
                      controller: destinationLongitude,
                      hintText: AppConstants.longitudeHint,
                      title: AppConstants.longitude,
                      icon: AppImages.longitudeLatitudeIcon,
                      isPasswordField: false,
                      inputFormatter: AppConstants.longitudeLatitudeFormatter),
                  SizedBox(height: 5.h,),
                  customButton(title: AppConstants.drawPolyline, onPressed: (){
                    if(destinationLatitude.text.isEmpty || destinationLongitude.text.isEmpty){
                      EasyLoading.showInfo('Destination latitude longitude required !');
                      return;
                    }
                    context.read<DrawPolyLineBloc>().add( FetchLocationEvent(LatLng(double.parse(destinationLatitude.text),double.parse(destinationLongitude.text))));
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget googleMap({required LatLng currentPosition,required Set<Marker> markers,required List<Polyline> polylines  }){
    return SizedBox(
        height: 1.sh,
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {},
          initialCameraPosition: CameraPosition(
            target: currentPosition,
            zoom: 15,
          ),
          markers:markers,
          polylines: Set.of(polylines),
        ));
  }
}

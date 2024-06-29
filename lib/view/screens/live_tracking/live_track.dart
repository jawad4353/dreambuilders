
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../data/hive-helper.dart';
import '../../../main.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_preferences.dart';
import '../../../utilis/suppoting_methods.dart';
import '../../../view_model/live_tracking_bloc/live_tracking_bloc.dart';
import '../../widgets/custom_appbar.dart';

class LiveTrackingMap extends StatefulWidget {
  const LiveTrackingMap({super.key});

  @override
  State<LiveTrackingMap> createState() => _LiveTrackingMapState();
}

class _LiveTrackingMapState extends State<LiveTrackingMap> {
  Location _location = Location();
  Marker markers = Marker(markerId: MarkerId('34'));

  @override
  void initState() {
    super.initState();
    context.read<LiveTrackingBloc>().add(FetchLocationEvent(context));
    listenToLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: myAppBar(
              title: AppConstants.liveTrack,
              context: context,
              shouldPop: false)),
      body: BlocBuilder<LiveTrackingBloc, LiveTrackingState>(
        builder: (context, state) {
          if (state is LiveTrackingInitial ||
              state is LiveTrackingLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          } else if (state is LiveTrackingLoadedState) {
            return SizedBox(
                height: 1.sh * 0.99,
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    // You can use the controller to interact with the map if needed
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.currentPosition.latitude ?? 0.0,
                      state.currentPosition.longitude ?? 0.0,
                    ),
                    zoom: 15,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId("current_location"),
                      position: LatLng(
                        state.currentPosition.latitude ?? 0.0,
                        state.currentPosition.longitude ?? 0.0,
                      ),
                      infoWindow: const InfoWindow(
                        title: "My Location",
                      ),
                    ),
                  },
                ));
          } else if (state is LiveTrackingErrorState) {
            return Center(child: Text(AppConstants.errorLoadingMap));
          }
          return Center(child: Text(AppConstants.errorLoadingMap));
        },
      ),
    );
  }

  listenToLocation() {
    _location.onLocationChanged.listen((LocationData currentLocation) {
      final currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      context
          .read<LiveTrackingBloc>()
          .add(LiveTrackingLoadEvent(currentPosition));
      saveLocationOffline(currentPosition);
    });
  }

  saveLocationOffline(LatLng currentPosition) async {
    //I added this check distance method as stream was continuously adding location in hive even if i move my phone slightly now
    // location will be added offline if its difference will be 100 meters or more
    double distance = SupportingMethods.calculateDistance(
        lat1: preferences.getDouble(AppPrefs.keyLatitude) ?? 0.0,
        lon1: preferences.getDouble(AppPrefs.keyLongitude) ?? 0.0,
        lat2: currentPosition.latitude,
        lon2: currentPosition.longitude);
    print(distance);
    if (distance > 20) {
      String address = await SupportingMethods.getAddressFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      HiveHelper.addLocation(
          latitude: currentPosition.latitude,
          longitude: currentPosition.longitude,
          name: address,
          time: DateTime.now().toString());
      preferences.setDouble(AppPrefs.keyLatitude, currentPosition.latitude);
      preferences.setDouble(AppPrefs.keyLongitude, currentPosition.longitude);
    }
  }
}

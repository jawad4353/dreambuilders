
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_text_styles.dart';
import '../../../utilis/string_formatting.dart';
import '../../../view_model/location_history_bloc/location_history_bloc.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dotted_line.dart';

class LocationHistory extends StatefulWidget {
  const LocationHistory({super.key});

  @override
  State<LocationHistory> createState() => _LocationHistoryState();
}

class _LocationHistoryState extends State<LocationHistory> {
  List<Color> myColors = [
    AppColors.primary,
    AppColors.green,
    AppColors.orange,
    AppColors.brown,
    AppColors.purple
  ];

  @override
  void initState() {
    super.initState();
    context.read<LocationHistoryBloc>().add(const LocationHistoryLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0.sp),
          child: myAppBar(
              title: AppConstants.locationHistory,
              context: context,
              shouldPop: false)),
      body: BlocBuilder<LocationHistoryBloc, LocationHistoryState>(
          builder: (context, state) {
        if (state is LocationHistoryLoadedState) {
          return state.listHistory.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return locationCard(
                        color: myColors[index % myColors.length],
                        date: state.listHistory[index].time,
                        lat: state.listHistory[index].latitude.toString(),
                        lng: state.listHistory[index].longitude.toString(),
                        name: state.listHistory[index].name);
                  },
                  separatorBuilder: (context, i) => SizedBox(
                        height: 6.h,
                      ),
                  itemCount: state.listHistory.length)
              : Center(
                  child: Text(
                  AppConstants.noHistory,
                  style: AppTextStyles.robotoMedium(
                      color: AppColors.grey0E0F10,
                      fontSize: 17.sp,
                      weight: FontWeight.w300),
                ));
          ;
        }
        if (state is LocationHistoryErrorState) {
          return Center(
              child: Text(
            state.error,
            style: AppTextStyles.robotoMedium(
                color: AppColors.greyB2AFAF,
                fontSize: 17.sp,
                weight: FontWeight.w400),
          ));
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget locationCard(
      {required Color color,
      required String date,
      required String name,
      required String lat,
      required String lng}) {

    return Container(
      height: 140.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
                color: AppColors.grey0E0F10.withOpacity(0.1),
                spreadRadius: 1.1,
                blurRadius: 0.5)
          ]),
      margin:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
      child: Row(
        children: [
          Container(
            width: 7.w,
            decoration: BoxDecoration(
                color: color.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25)),
          ),
          Stack(
            children: [
              SizedBox(height: 130.h, width: 1.sw * 0.95),
              Positioned(
                left: 0.w,
                right: 0.w,
                top: 3.h,
                child: Center(
                  child: Text(
                    StringFormatting.formatLocationTime(date: date),
                    style: AppTextStyles.robotoMedium(
                        color: color,
                        fontSize: 15.0.sp,
                        weight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                left: 0.w,
                right: 0.w,
                top: 25.h,
                child: Center(
                  child: Text(
                    name,
                    style: AppTextStyles.robotoMedium(
                        fontSize: 15.sp,
                        weight: FontWeight.w500,
                        color: AppColors.primary),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              Positioned(
                  top: 70.h,
                  left: 11.w,
                  right: 11.w,
                  child: CustomPaint(
                    painter: DottedLinePainter(),)),
              Positioned(
                bottom: 10,
                left: 8,
                child: Column(
                  children: [
                    Text(
                      AppConstants.longitude,
                      style: AppTextStyles.robotoMedium(
                          color: color,
                          fontSize: 15.0.sp,
                          weight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      lat.substring(0, 6),
                      style: AppTextStyles.robotoMedium(
                          fontSize: 16.0.sp,
                          weight: FontWeight.w500,
                          color: AppColors.grey0E0F10.withOpacity(0.8)),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 8,
                child: Column(
                  children: [
                    Text(
                      AppConstants.latitude,
                      style: AppTextStyles.robotoMedium(
                          color: color,
                          fontSize: 15.0.sp,
                          weight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        lng.substring(0, 6),
                        style: AppTextStyles.robotoMedium(
                            fontSize: 15.0.sp,
                            weight: FontWeight.w500,
                            color: AppColors.grey0E0F10.withOpacity(0.8)),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

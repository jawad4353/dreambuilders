import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dreambuilders/view/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_text_styles.dart';
import '../../view_model/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import '../dialogues/exit_dialogue.dart';
import 'draw_polyline/draw_polyline.dart';
import 'home/home.dart';
import 'live_tracking/live_track.dart';
import 'location_history/location_history.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  var listScreens = [
    const Home(),
    const LiveTrackingMap(),
    const ProfileScreen(),
    const LocationHistory(),
    const DrawPolyLine()
  ];
  int i = 0;

  @override
  void initState() {
    super.initState();
    context.read<BottomNavBarBloc>().add(const BottomNavBarChangePageEvent(0));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      bool exit=await onExit(context);
      return exit;
    }, child: BlocBuilder<BottomNavBarBloc, BottomNavBarStates>(
        builder: (context, state) {
      if (state is BottomNavBarLoadedState) {
        return Scaffold(
          body: listScreens[state.pageIndex],
          bottomNavigationBar: BottomBarCreative(
            color: Colors.black.withOpacity(0.7),
            indexSelected: state.pageIndex,
            items: [
              TabItem(
                icon: FontAwesomeIcons.home,
                title: AppConstants.home,
              ),
              TabItem(
                  icon: FontAwesomeIcons.city, title: AppConstants.liveTrack),
              TabItem(
                  icon: FontAwesomeIcons.solidUser,
                  title: AppConstants.profile),
              TabItem(
                  icon: FontAwesomeIcons.locationPinLock,
                  title: AppConstants.history),
              TabItem(
                  icon: FontAwesomeIcons.directions,
                  title: AppConstants.polyline),
            ],
            titleStyle: AppTextStyles.robotoMedium(
                color: AppColors.grey0E0F10,
                fontSize: 14.sp,
                weight: FontWeight.w300),
            isFloating: true,
            highlightStyle: HighlightStyle(
              isHexagon: true,
              background: AppColors.primary,
            ),
            backgroundColor: AppColors.white,
            colorSelected: AppColors.primary,
            onTap: (a) {
              context
                  .read<BottomNavBarBloc>()
                  .add(BottomNavBarChangePageEvent(a));
            },
          ),
        );
      }
      return const SizedBox();
    }));
  }
}

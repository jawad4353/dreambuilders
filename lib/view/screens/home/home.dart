import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:workmanager/workmanager.dart';
import '../../../main.dart';
import '../../../network_config/firebase_service.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_images.dart';
import '../../../utilis/app_preferences.dart';
import '../../../utilis/app_routes.dart';
import '../../../utilis/app_text_styles.dart';
import '../../../view_model/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import '../../../view_model/location_history_bloc/location_history_bloc.dart';
import '../../../view_model/profile_bloc/profile_bloc.dart';
import '../../auth/login.dart';
import '../../dialogues/logout.dart';
import '../../widgets/custom_button.dart';
import '../more/web_view_helper.dart';
import 'notification_service.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Color> myColors=[AppColors.green,AppColors.brown,AppColors.black,AppColors.primary,AppColors.orange,AppColors.purple];

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },icon: Image.asset(AppImages.iconDrawer,color: AppColors.primary,height: 38.h,),),
          iconTheme: IconThemeData(color: AppColors.primary,size: 30),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          title:Container(
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(27),
                color: AppColors.white,
                boxShadow:  [BoxShadow(color: AppColors.greyB2AFAF,spreadRadius: 0.5)]
            ),
            child: TextField(
              cursorColor: AppColors.primary,
              style:AppTextStyles.robotoMedium(color: AppColors.greyB2AFAF, fontSize: 13.sp, weight: FontWeight.normal),
              onChanged: (a){
              },
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.only(top: 9.h),
                prefixIcon:  Icon(Icons.search,color:  AppColors.greyB2AFAF,),
                hintText:  AppConstants.search,
                hintStyle: AppTextStyles.robotoMedium(color: AppColors.greyB2AFAF, fontSize: 13.h, weight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ) ,
          actions: [
            IconButton(onPressed: (){
            }, icon:Image.asset(AppImages.iconNotifications,color: AppColors.primary,height: 28.h,)),
          ],
        ),
        drawer:  Drawer(
          backgroundColor: AppColors.white,
          child:  Container(
            color: AppColors.white,
            child: ListView(
              children: [

                InkWell(
                  onTap: (){
                    context.read<BottomNavBarBloc>().add(const BottomNavBarChangePageEvent(2));
                  },
                  child: BlocBuilder<ProfileBloc,ProfileStates>(
                    builder: (context,state) {
                      if(state is ProfileLoadingState){
                        return Stack(children: [
                          _profile(imageUrl: '', name: preferences.getString(AppPrefs.keyName)??'', email:preferences.getString(AppPrefs.keyEmail)??''),
                           Center(child:  CircularProgressIndicator(color: AppColors.white,)),

                        ],);
                      }
                      if(state is ProfileLoadedState){
                        return  _profile(imageUrl: state.myModel.imageUrl, name:  state.myModel.name, email: state.myModel.email);
                      }
                      if(state is ProfileErrorState){
                  
                        return  _profile(imageUrl: 'noimage', name: '', email:'');
                      }
                      return const SizedBox();
                  
                    }
                  ),
                ),
                _buttons(icon: AppImages.iconShareApp,text: AppConstants.shareApp),
                _buttons(icon: AppImages.iconAboutUs,text: AppConstants.aboutUs),
                _buttons(icon:AppImages.iconPrivacyPolicy,text:AppConstants.contactUs),
                _buttons(icon: AppImages.iconLogOut,text:AppConstants.logOut ),
                _buttons(icon: AppImages.iconDelete,text:AppConstants.deleteAccount ),


                 Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:  EdgeInsets.only(right: 20.h),
                    child: Text(AppConstants.appVersion,style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 15.sp, weight: FontWeight.w300),),
                  ),
                )
              ],
            ),
          ),
        ),

        body:Center(
          child: SizedBox(
            width: 290.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customButton(onPressed: () async {
                  bool permissionGranted=await NotificationService.checkAndRequestNotificationPermission();
                  if(permissionGranted){
                    Workmanager().registerPeriodicTask('jawad', 'showNotification',frequency: const Duration(minutes: 10),inputData: {'name':'jawad'},constraints:
                    Constraints(networkType: NetworkType.not_required,requiresBatteryNotLow: false,requiresCharging: false,requiresStorageNotLow: false,requiresDeviceIdle: false));
                  }}, title: AppConstants.schedulePeriodicNotification),


                customButton(onPressed: () async {Workmanager().cancelAll();},
                    title: AppConstants.cancelPeriodicTask),

                customButton(onPressed: () async {
                  bool permissionGranted=await NotificationService.checkAndRequestNotificationPermission();
                  if(permissionGranted){NotificationService.showNotification();}},
                    title: AppConstants.getInstantNotifications),
              ],),
          ),
        ),
      ),
    );
  }


  Widget _buttons({required String text,required String icon}) {
    return InkWell(
      onTap: () async {
        if(text==AppConstants.deleteAccount){
          bool deleted=await FirebaseAuthService.deleteAccount();
          if(deleted){
            Navigator.pushReplacement(context, MyRoute(Login()));
          }

        }
        if (text == AppConstants.shareApp) {
          Share.share(AppConstants.shareAppUrl);
        }
        if (text == AppConstants.aboutUs) {
          Navigator.push(context, MyRoute( WebViewHelper(AppConstants.aboutUsUrl,AppConstants.aboutUs)));
        }
        if (text == AppConstants.contactUs) {
          Navigator.push(context, MyRoute( WebViewHelper(AppConstants.contactUsUrl,AppConstants.contactUs)));
        }
        if (text == AppConstants.logOut) {
          bool s = await onLogOut(context);
          if (s) {
            bool logout= await FirebaseAuthService.signOut();
            context.read<ProfileBloc>().add(const ProfileClearEvent());
            context.read<LocationHistoryBloc>().add(const LocationHistoryClearEvent());
            if(logout){
              Navigator.pushReplacement(context, MyRoute(const Login()));
            }

          }
        }
      },
      child: Container(
        height: 50,
        color: AppColors.white,
        child: Row(
          children: [
            const SizedBox(width: 10, height: 5,),
            Image.asset(icon, height: 30.h, color: AppColors.primary,),
            const SizedBox(width: 14,),
            Text(text, style: AppTextStyles.robotoMedium(
                color: AppColors.black191B32,
                fontSize: 16.sp,
                weight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }


  Widget _profile({required String imageUrl,required String name,required String email}){
    return  UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: AppColors.primary ),
        currentAccountPicture: Container(
          height: 120.h,
          width: 120.h,
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
              image:imageUrl!='noimage' ?  DecorationImage(image:CachedNetworkImageProvider(imageUrl,)  , fit: BoxFit.cover)
                  : DecorationImage(image: Image.asset(AppImages.imgLogo).image, fit: BoxFit.cover)
          ),
        ),
        accountName:  Text(name,style:AppTextStyles.
        robotoMedium(color: AppColors.white, fontSize: 18.sp, weight: FontWeight.w600)),
        accountEmail:  Text(email,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 16.sp, weight: FontWeight.w400),));
  }


}


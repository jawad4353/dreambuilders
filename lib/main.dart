
import 'package:dreambuilders/splash_screen.dart';
import 'package:dreambuilders/utilis/app_colors.dart';
import 'package:dreambuilders/view_model/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import 'package:dreambuilders/view_model/cement_bloc/cement_bloc.dart';
import 'package:dreambuilders/view_model/login_bloc/login_bloc.dart';
import 'package:dreambuilders/view_model/profile_bloc/profile_bloc.dart';
import 'package:dreambuilders/view_model/register_bloc/register_bloc.dart';
import 'package:dreambuilders/view_model/web_view_bloc/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/hive-helper.dart';
import 'network_config/firebase_service.dart';


late SharedPreferences preferences;
String ? version;
String googleMapsApiKeyHere='';  //give you key here also in android manifes.xml and info.plist file swift file
String ? bearerToken;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.init();
  FirebaseAuthService.initialize();
  FirebaseAuthService.getAppVersion();
  preferences=await SharedPreferences.getInstance();
  runApp( MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:AppColors.primary
  ));
}


class MyApp extends StatelessWidget   {
  Size ? size;
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize:  Size(size!.width, size!.height),
      child: MultiBlocProvider(
        providers: [
         BlocProvider(create: (context)=>WebViewBloc()),
          BlocProvider(create: (context)=>RegisterBloc()),
          BlocProvider(create: (context)=>LoginBloc()),
          BlocProvider(create: (context)=>BottomNavBarBloc()),
          BlocProvider(create: (context)=>ProfileBloc()),
          BlocProvider(create: (context)=>CementBloc()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }

}

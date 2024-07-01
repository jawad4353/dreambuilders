
import 'package:flutter/services.dart';

import '../main.dart';

class AppConstants{
  static String logIn='Log IN ';
//Login
  static String login='Login';
  static String welcomeBack='Welcome Back';
  static String enterUsernamePassword='Enter your Email & Password';
  static String alreadyHaveAccount='Already have an account? ';
  static String name='Name';
  static String nameHint='Jawad';
  static String designationHint='Civil Engineer';
  static String email='Email';
  static String emailHint='abc@gmail.com';
  static String password='Password';
  static String passwordHint='●●●●●●';
  static String rememberMe='Remember Me';
  static String forgotPassword='Forgot Password ?';
  static FilteringTextInputFormatter emailFormatter=passwordFormatter;
  static FilteringTextInputFormatter longitudeLatitudeFormatter=FilteringTextInputFormatter.allow(RegExp(r'^[0-9. .]*$'));
  static FilteringTextInputFormatter passwordFormatter= FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_\-@.]*$'));
  static FilteringTextInputFormatter nameFormatter=FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z - ]'));
 //boarding
  static String boardingTitle='"Empowering Your Vision"';
  static String boardingSubtitle='Say Goodbye to Manual Estimations . Calculate, Plan, Build with Confidence'
  'Effortlessly Estimate Materials and Costs for Every Project Detail.';
  static String skip='Skip';
  static String next='Next';
  static String ok='Ok';

  //Register
  static String signUp='Sign Up';
  static String code='Code';
  static String enterRealInformation='Enter your information';

  static String confirmPassword='Confirm Password';
  static String phoneNumber='Phone  Number';
  static String session='Session';
  static String dontHaveAccount='Didn’t have an account? ';

//get otp forgetpassword screen
  static String forgetPassword='Forget Password';
  static String enterEmail='Enter email to get reset link';
  static String getLink='Get Email Link';

  //home
  static String contactUs='Contact Us';
  static String search='Search';
  static String shareApp='Share App';
  static String privacy='Privacy Policy';
  static String logOut='Logout';
  static String contactUsUrl='https://dreambuilders76566.000webhostapp.com/';
  static String aboutUsUrl='https://dreambuilder56776.000webhostapp.com/';
  static String shareAppUrl='https://drive.google.com/file/d/1mM315ZUGUZfLaU3LMpz91g3O8NksxRl2/view?usp=sharing';
  static String appVersion='version $version';
  static String viewImage='View Image';
  static String home='Home';
  static String createNotification='Create Notification';
  static String features='Features';
  static String foregroundChannelDescription=' This jawad_foreground is channel to display foreground notifications';
  static String foregroundChannelKey='Jawad Foreground';
  static String channelIcon='resource://mipmap/ic_launcher';
  static String notification=' Notification ';
  static String notificationBody='App is in Resumed state ';
  static String schedulePeriodicNotification='Schedule Notifications periodic';
  static String cancelPeriodicTask='Cancel Periodic Task';
  static String getInstantNotifications='Get Instant Notification';
  static String deleteAccount='Delete Account';

  //profile
  static String profile='Profile';
  static String designation='Designation';
  static String userID='User ID';
  static String profilePicture='Profile Picture';
  static String registrationDate='Registration Date';

  //drawer
  static String areYouSureLogout='Are you sure you want to logout  ?';
  static String areYouSureExit=' Do you want to exit app ?';
  static String exit='Exit';
  static String logout='Logout';
  static String cancel='Cancel';


  //maps
  static String bricks='Bricks';
  static String brickPrice='Brick Price';
  static String stealPrice='Steal Price';
  static String cementBagPrice='Cement Bag ';
  static String tilePrice='Tile Price';
  static String errorLoadingMap='Error loading map';
  static String loading='Loading';
  static String latitude='Latitude';
  static String latitudeHint='31.3';
  static String longitude='Longitude';
  static String longitudeHint='74.3';

  //location history
  static String tiles='Tiles';
  static String calculator='Calculator';
  static String calculate='Calculate';



  //draw polyline
  static String cement='Cement';
  static String length='Length';
  static String thickness='Thickness';
  static String hintLength='2 meters';
  static String hintWidth='10 meters';
  static String hintThickness='0.5 meter';
  static String width='Width';
  static String ofWall=' of wall';
  static String ofTile=' of tile';
  static String ofFloor=' of floor';
  static String wastePercent='Waste Percentage';
  static String hintWaste=' 3 %';
  static String hintTile=' 5 cm';
}
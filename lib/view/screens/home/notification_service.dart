import 'package:awesome_notifications/awesome_notifications.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';

/*
This class have methods to work with notifications i am using awesome notifications package
 */
class NotificationService {
  static int _notificationId = 0;

  static void initialize() {
    AwesomeNotifications().initialize(
      AppConstants.channelIcon,
      [
        NotificationChannel(
          channelKey: AppConstants.foregroundChannelKey,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          enableVibration: true,
          importance: NotificationImportance.High,
          channelDescription:
          AppConstants.foregroundChannelDescription,
          defaultColor: AppColors.white,
          ledColor: AppColors.white,
          channelName:AppConstants.foregroundChannelKey,
        ),
      ],
    );
  }


  static void showNotification() async {
    _notificationId++;
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _notificationId,
          channelKey: AppConstants.foregroundChannelKey,
          title:  AppConstants.notification+_notificationId.toString(),
          body: AppConstants.notificationBody,
        ),
    //schedule: NotificationInterval(interval: 600,repeats: true)
    );
    listenNotificationActions();
  }


  static Future<bool> checkAndRequestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
      isAllowed = await AwesomeNotifications().isNotificationAllowed();
    }
    return isAllowed;
  }


  static listenNotificationActions(){
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
  }
}






class NotificationController {

  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    print(receivedNotification.title.toString()+' has arrived');
  }

  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    print(receivedNotification.actionType);
  }

  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    print(receivedAction.title.toString()+' dismissed');
  }

  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    print(receivedAction.title.toString()+' recieved');
  }

}
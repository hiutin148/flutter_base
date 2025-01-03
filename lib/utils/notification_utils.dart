import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> onDidReceiveNotificationResponse(
  NotificationResponse notificationResponse,
) async {
  final payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    print(payload);
  }
}

class NotificationUtils {
  static late final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin;

  static Future<void> initializeLocalNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'ic_launcher',
    );
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        print('IOS onDidReceiveLocalNotification');
      },
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static Future<void> showNotification() async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      ticker: 'ticker',
      styleInformation: BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('ic_launcher'),
      ),
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      notificationDetails,
      payload: 'item x',
    );
  }
}

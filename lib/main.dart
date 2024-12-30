import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_base/app.dart';
import 'package:flutter_base/firebase_options.dart';
import 'package:flutter_base/locator.dart';
import 'package:flutter_base/utils/notification_utils.dart';

Future<void> mainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationUtils.initializeLocalNotifications();
  // await NotificationUtils.flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // await NotificationUtils.flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  runApp(const MyApp());
}

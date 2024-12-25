import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_base/app.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/configs/app_env_config.dart';
import 'package:flutter_base/firebase_options.dart';
import 'package:flutter_base/utils/notification_utils.dart';

void main() async {
  AppConfigs.env = Environment.prod;
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationUtils.initializeLocalNotifications();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

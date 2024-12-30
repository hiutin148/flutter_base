import 'dart:async';

import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/configs/app_env_config.dart';
import 'package:flutter_base/main.dart';

void main() async {
  AppConfigs.env = Environment.prod;
  unawaited(mainApp());
}

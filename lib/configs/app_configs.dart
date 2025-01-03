import 'package:flutter_base/configs/app_env_config.dart';
import 'package:flutter_base/models/enums/language.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = 'NEWWAVE';

  static Environment env = Environment.prod;

  ///API Env
  static String get baseUrl => env.baseUrl;
  static String get mocKyBaseUrl => 'https://run.mocky.io';

  static String get envName => env.envName;

  ///Paging
  static const pageSize = 40;
  static const pageSizeMax = 1000;

  ///Local
  static const defaultLanguage = Language.english;

  ///DateFormat

  static const dateDisplayFormat = 'dd/MM/yyyy';
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  static const dateTimeAPIFormat =
      'YYYY-MM-DDThh:mm:ssTZD'; //Use DateTime.parse(date) instead of ...
  static const dateAPIFormat = 'dd/MM/yyyy';

  ///Date range
  static final identityMinDate = DateTime(1900);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  ///Max file
  static const maxAttachFile = 5;

  static const scrollThreshold = 500.0;
}

class FirebaseConfig {
  // TODO: Do something
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}

class MovieAPIConfig {
  static const String apiKey = '26763d7bf2e94098192e629eb975dab0';
}

class UpGraderAPIConfig {
  static const String apiKey = '';
}

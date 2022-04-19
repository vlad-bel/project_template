import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();

  static final AppConfig _singleton = AppConfig._();

  static bool get IS_PRODUCTION =>
      kReleaseMode || ENVIRONMENT.toLowerCase().startsWith('prod');

  static String get ENVIRONMENT => dotenv.env['ENVIRONMENT'] ?? 'dev';

  static String get API_URI => dotenv.env['API_URI']!;


  Future<void> load() async {
    await dotenv.load(fileName: '.env');
    debugPrint('ENVIRONMENT: $ENVIRONMENT');
    debugPrint('API ENDPOINT: $API_URI');
  }
}

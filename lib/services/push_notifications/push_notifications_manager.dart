import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:project_template/common/urls.dart';
import 'package:project_template/services/network/api_manager.dart';

class PushNotificationManager {
  final FirebaseMessaging firebaseMessaging;

  PushNotificationManager() : firebaseMessaging = FirebaseMessaging.instance;

  Future<AuthorizationStatus> askPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.notDetermined) {
      return settings.authorizationStatus;
    }
    final NotificationSettings newSettings =
        await firebaseMessaging.requestPermission();
    if (newSettings.authorizationStatus == AuthorizationStatus.authorized) {
      firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true);
    }
    return newSettings.authorizationStatus;
  }

  Future<bool> sendToken() async {
    final firToken = await firebaseMessaging.getToken();

    if (firToken != null) {
      try {
        final response = await GetIt.instance.get<ApiManager>().post(
          AppUrls.api_url,
          data: {'token': firToken},
        );
        final statusCode = (response.statusCode ?? 500);
        if (statusCode >= 200) {
          return true;
        }
        throw Exception('send_token_error');
      } catch (e) {
        rethrow;
      }
    }
    return false;
  }
}

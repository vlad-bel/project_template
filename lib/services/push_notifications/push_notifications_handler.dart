import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:routemaster/routemaster.dart';

class PushNotificationHandler {
  final RoutemasterDelegate routemasterDelegate;
  PushNotificationHandler({required this.routemasterDelegate});

  void handlePushNotification(RemoteMessage remoteMessage) {
    // TODO write link parser
    // write the whole path with stack you'd need aka /home/categories/:categoryID/:productID
    // how to use [routemasterDelegate.replace('');]
  }
}

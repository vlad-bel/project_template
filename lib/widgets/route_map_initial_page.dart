import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class RouteMapInitialPage extends StatefulWidget {
  final Widget child;

  const RouteMapInitialPage({required this.child});

  @override
  _RouteMapInitialPageState createState() => _RouteMapInitialPageState();
}

class _RouteMapInitialPageState extends State<RouteMapInitialPage> {
  StreamSubscription? _linkSubscription;
  StreamSubscription? _pushSubscription;

  void initFirstLinks() async {
    RemoteMessage? launchMessage;
    Uri? launchUrl;

    try {
      // Make sure you made initial setting
      // on both iOS and Android side, for this to work:
      // check https://pub.dev/packages/firebase_messaging
      // check https://pub.dev/packages/uni_links
      launchMessage = await FirebaseMessaging.instance.getInitialMessage();
      launchUrl = await getInitialUri();
    } catch (e) {
      // may throw an error
      print(e);
    }

    if (launchUrl != null) {}
    if (launchMessage != null) {}
  }

  @override
  void initState() {
    super.initState();
    initFirstLinks();
    _linkSubscription = linkStream.listen((event) {});
    _pushSubscription = FirebaseMessaging.onMessage.listen((event) {});
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    _pushSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

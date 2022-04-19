import 'package:routemaster/routemaster.dart';

class LinkHandler {
  final RoutemasterDelegate routemasterDelegate;
  LinkHandler({required this.routemasterDelegate});

  void handleLink(Uri uri) {
    // TODO write link parser
    // write the whole path with stack you'd need aka /home/categories/:categoryID/:productID
    // how to use [routemasterDelegate.replace('');]
  }
}

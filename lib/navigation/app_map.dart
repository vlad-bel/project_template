import 'package:flutter/material.dart';
import 'package:project_template/flows/app/datalist/datalist_page.dart';
import 'package:project_template/flows/app/user_details/user_details_page.dart';
import 'package:project_template/widgets/route_map_initial_page.dart';
import 'package:project_template/widgets/tab_page.dart';
import 'package:routemaster/routemaster.dart';

final tabBarPageKey = GlobalKey();

class AppRouteMap extends RouteMap {
  AppRouteMap({
    int initialTabPage = 0,
  }) : super(
            onUnknownRoute: _onUnknownRoute,
            routes: _routes(
              initialTabPage: initialTabPage,
            ));

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');

  static Map<String, PageBuilder> _routes({
    required int initialTabPage,
  }) {
    return {
      '/': (_) => TabPage(
            pageBuilder: (child) => MaterialPage(child: child),
            child: TabBarPage(
              initialTabPage: initialTabPage,
              key: tabBarPageKey,
            ),
            paths: const [
              "/data_list",
              "/user_details",
            ],
          ),
      "/data_list": (routeData) {
        ///we can get parameters for the route from queryParameters
        ///but it can do only with String type
        ///That's why if we wanna pass Objects,
        ///it needs to convert in JSON objects
        // final projectParam = routeData.queryParameters['field_name'];

        return MaterialPage(child: DataList());
      },
      "/user_details": (_) => MaterialPage(child: UserDetails()),
    };
  }
}

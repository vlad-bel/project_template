import 'package:flutter/material.dart';
import 'package:project_template/flows/auth/signin/signin_page.dart';
import 'package:project_template/flows/auth/signup/signup_page.dart';
import 'package:routemaster/routemaster.dart';

class AuthRouteMap extends RouteMap {
  AuthRouteMap()
      : super(
          onUnknownRoute: _onUnknownRoute,
          routes: _routes,
        );

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');

  static final Map<String, PageBuilder> _routes = {
    SigninPage.path: (_) => MaterialPage(child: SigninPage()),
    SignupPage.path: (_) => MaterialPage(child: SignupPage()),
  };
}

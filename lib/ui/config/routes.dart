import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';
import 'package:monzo_client/ui/config/theme.dart';
import 'package:monzo_client/ui/splash.dart';
import 'package:monzo_client/ui/home/home.dart';
import 'package:monzo_client/ui/login/login.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";

  static void configureRoutes(Router router, AuthManager authManager) {
    router.notFoundHandler = new Handler(handlerFunc: (context, params) {
      print("Route not found.");
    });

    router.define(
        root,
        handler: new Handler(handlerFunc: (context, params) {
          return new Theme(
              data: MonzoTheme.dark,
              child: new Splash(router: router, authManager: authManager)
          );
        })
    );

    router.define(
        login,
        handler: new Handler(handlerFunc: (context, params) {
          return new Theme(
              data: MonzoTheme.dark,
              child: new Login(router: router, authManager: authManager)
          );
        })
    );

    router.define(
        home,
        handler: new Handler(handlerFunc: (context, params) {
          return new Home(router: router, authManager: authManager);
        }),
    );
  }
}

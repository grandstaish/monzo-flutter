import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:monzo_flutter/app_component.dart';
import 'package:monzo_flutter/ui/config/theme.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";

  static void configureRoutes(AppComponent appComponent) {
    var router = appComponent.router();

    router.notFoundHandler = new Handler(handlerFunc: (context, params) {
      print("Route not found.");
    });

    router.define(
        root,
        handler: new Handler(handlerFunc: (context, params) {
          return new Theme(
              data: MonzoTheme.dark,
              child: appComponent.splash()
          );
        })
    );

    router.define(
        login,
        handler: new Handler(handlerFunc: (context, params) {
          return new Theme(
              data: MonzoTheme.dark,
              child: appComponent.login()
          );
        })
    );

    router.define(
        home,
        handler: new Handler(handlerFunc: (context, params) {
          return appComponent.home();
        }),
    );
  }
}

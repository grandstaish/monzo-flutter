import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';

class Splash extends StatefulWidget {
  Splash({
    Key key,
    @required this.router,
    @required this.authManager
  }) : assert(router != null),
       assert(authManager != null),
       super(key: key);

  final Router router;
  final AuthManager authManager;

  @override
  State<StatefulWidget> createState() {
    return new _SplashState();
  }
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    await widget.authManager.init();

    String route;
    if (widget.authManager.loggedIn) {
      route = '/home';
    } else {
      route = '/login';
    }

    // No transition
    var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return child;
    };

    widget.router.navigateTo(
        context,
        route,
        replace: true,
        transitionDuration: const Duration(milliseconds: 0),
        transition: TransitionType.custom,
        transitionBuilder: transition
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return new Container(
        alignment: Alignment.center,
        color: theme.backgroundColor,
        child: new CircularProgressIndicator()
    );
  }
}

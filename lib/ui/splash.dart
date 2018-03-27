import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';

class Splash extends StatefulWidget {
  final Router _router;
  final AuthManager _authManager;

  const Splash(this._router, this._authManager);

  @override
  State<StatefulWidget> createState() {
    return new _SplashState(_router, _authManager);
  }
}

class _SplashState extends State<Splash> {
  final AuthManager _authManager;
  final Router _router;

  _SplashState(this._router, this._authManager);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    await _authManager.init();

    String route;
    if (_authManager.loggedIn) {
      route = '/home';
    } else {
      route = '/login';
    }

    // No transition
    var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return child;
    };

    _router.navigateTo(
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

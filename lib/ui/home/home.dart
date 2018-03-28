import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
    @required this.router,
    @required this.authManager
  }) : assert(router != null),
       assert(authManager != null),
       super(key: key);

  final Router router;
  final AuthManager authManager;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Text("Hello world!"),
    );
  }
}

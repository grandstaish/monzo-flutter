import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';

class Home extends StatelessWidget {
  final Router _router;
  final AuthManager _authManager;

  const Home(this._router, this._authManager);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Text("Hello world!"),
    );
  }
}

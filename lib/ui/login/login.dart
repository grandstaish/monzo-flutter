import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';

class Login extends StatelessWidget {
  final Router _router;
  final AuthManager _authManager;

  const Login(this._router, this._authManager);

  void _onLoginPressed() {
    print("Hello world!");
  }

  void _onContinuePressed() {
    print("Hello world!");
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = Strings.of(context);
    return new Column(
      children: <Widget>[
        new Expanded(child: new Container()),
        new RaisedButton(
          onPressed: _onContinuePressed,
          child: new Text(strings.sharedContinueButton()),
        ),
        new FlatButton(
            onPressed: _onLoginPressed,
            child: new Text(strings.onboardingLoginButton())
        )
      ]
    );
  }
}

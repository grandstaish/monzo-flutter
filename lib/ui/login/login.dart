import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';
import 'package:monzo_client/ui/common/action_buttons.dart';

class Login extends StatelessWidget {
  final Router _router;
  final AuthManager _authManager;

  Login(this._router, this._authManager);

  void _onContinuePressed() {
    print("Hello world!");
  }

  void _onLoginPressed() {
    print("Hello world!");
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Strings strings = Strings.of(context);
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          color: theme.backgroundColor, // TODO: video
        ),
        new Center(
          child: new Text("Monzo", style: theme.textTheme.display3),
        ),
        new ActionButtons(
          primaryButtonText: strings.sharedContinueButton(),
          primaryButtonHandler: _onContinuePressed,
          secondaryButtonText: strings.onboardingLoginButton(),
          secondaryButtonHandler: _onLoginPressed,
        )
      ],
    );
  }
}

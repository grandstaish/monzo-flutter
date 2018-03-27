import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';
import 'package:monzo_client/ui/config/palette.dart';
import 'package:monzo_client/ui/common/action_buttons.dart';
import 'package:monzo_client/ui/common/monzo_logo.dart';
import 'package:monzo_client/ui/common/video/center_crop_video.dart';
import 'package:monzo_client/ui/common/video/video_lifecycle.dart';

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
    Strings strings = Strings.of(context);
    return new Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        new DecoratedBox(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Palette.darkBlue.withAlpha(Palette.ALPHA_50),
                Palette.darkBlue.withAlpha(Palette.ALPHA_50),
                Palette.darkBlue
              ]
            ),
          ),
          position: DecorationPosition.foreground,
          child: new _OnboardingVideoBackground(),
        ),
        new Center(child: new AnimatedMonzoLogo()),
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

class AnimatedMonzoLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AnimatedMonzoLogoState();
}

class _AnimatedMonzoLogoState extends State<AnimatedMonzoLogo> {
  Timer _timer;
  MonzoLogoStyle _logoStyle = MonzoLogoStyle.markOnly;

  _AnimatedMonzoLogoState() {
    _timer = new Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _logoStyle = MonzoLogoStyle.horizontal;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new MonzoLogo(
      width: 350.0,
      height: 58.0,
      textColor: Palette.white,
      style: _logoStyle,
    );
  }
}

class _OnboardingVideoBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleVideoPlayer(
        "assets/sunlight.mp4",
        (context, controller) {
          return new CenterCropVideo(controller);
        },
        isLooping: true
    );
  }
}

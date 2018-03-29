import 'dart:async';
import 'package:meta/meta.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';
import 'package:monzo_client/ui/config/palette.dart';
import 'package:monzo_client/ui/common/action_buttons.dart';
import 'package:monzo_client/ui/common/center_crop.dart';
import 'package:monzo_client/ui/common/monzo_logo.dart';
import 'package:monzo_client/ui/common/video/video_player.dart';
import 'package:monzo_client/ui/common/video/video_lifecycle.dart';

const MethodChannel _channel = const MethodChannel("com.monzo/oauthPlugin");

class Login extends StatefulWidget {
  Login({
    Key key,
    @required this.router,
    @required this.authManager
  }) : assert(router != null),
       assert(authManager != null),
       super(key: key);

  final Router router;
  final AuthManager authManager;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    _channel.invokeMethod('connect');

    var url = widget.authManager.authUrl;
    _channel.invokeMethod('setUrl', <String, dynamic>{'url': url});

    _channel.setMethodCallHandler(_handlePlatformMessages);
  }

  @override
  void dispose() {
    super.dispose();
    _channel.invokeMethod('disconnect');
  }

  void _onContinuePressed(BuildContext context) {
    print("Hello world!");
  }

  void _onLoginPressed(BuildContext context) {
    _channel.invokeMethod('launch');
  }

  Future<Null> _handlePlatformMessages(MethodCall call) async {
    switch (call.method) {
      case "onRedirect":
        var uri = call.arguments['uri'];
        setState(() {
          // Loading
        });
        bool successful = await widget.authManager.login(uri);
        setState(() {
          // Not loading
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new _OnboardingVideoBackground(),
        new _AnimatedMonzoLogo(),
        new Align(
          alignment: Alignment.bottomCenter,
          child: _AnimatedActionButtons(
            onContinuePressed: _onContinuePressed,
            onLoginPressed: _onLoginPressed,
          ),
        )
      ],
    );
  }
}

class _AnimatedMonzoLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AnimatedMonzoLogoState();
}

class _AnimatedMonzoLogoState extends State<_AnimatedMonzoLogo> {
  Timer _timer;
  MonzoLogoStyle _logoStyle = MonzoLogoStyle.markOnly;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(const Duration(milliseconds: 600), () {
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

class _AnimatedActionButtons extends StatefulWidget {
  _AnimatedActionButtons({
    this.onContinuePressed,
    this.onLoginPressed
  });

  final ActionCallback onContinuePressed;
  final ActionCallback onLoginPressed;

  @override
  State<StatefulWidget> createState() => _AnimatedActionButtonsState();
}

class _AnimatedActionButtonsState extends State<_AnimatedActionButtons> {
  Timer _timer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(const Duration(milliseconds: 1400), () {
      setState(() {
        _visible = true;
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
    Strings strings = Strings.of(context);
    return new AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: new Duration(milliseconds: 300),
      child: new ActionButtons(
        primaryButtonText: strings.sharedContinueButton(),
        primaryButtonHandler: widget.onContinuePressed,
        secondaryButtonText: strings.onboardingLoginButton(),
        secondaryButtonHandler: widget.onLoginPressed,
      ),
    );
  }
}

class _OnboardingVideoBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new VideoPlayerLifecycle(
        asset: "assets/sunlight.mp4",
        childBuilder: (BuildContext context, VideoPlayerController controller, bool videoReallyPlaying) {
          if (controller.value.initialized && videoReallyPlaying) {
            final size = controller.value.size;
            return new DecoratedBox(
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
              child: new CenterCrop(
                  size: size,
                  child: new VideoPlayer(controller)
              )
            );
          } else {
            return new Container(color: Palette.darkBlue);
          }
        },
        isLooping: true
    );
  }
}

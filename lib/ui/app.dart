import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/ui/config/theme.dart';
import 'package:monzo_client/ui/config/routes.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';

class App extends StatelessWidget {
  final Router _router = new Router();
  final AuthManager _authManager = new AuthManager();

  App() {
    Routes.configureRoutes(_router, _authManager);
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = Strings.of(context);
    return new MaterialApp(
      title: strings.appTitle(),
      localizationsDelegates: [
        new StocksLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'UK'),
      ],
      theme: MonzoTheme.light,
      onGenerateRoute: _router.generator,
    );
  }
}

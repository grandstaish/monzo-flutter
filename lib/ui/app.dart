import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/ui/config/theme.dart';
import 'package:monzo_client/ui/config/routes.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';
import 'package:monzo_client/data/accounts/accounts_manager.dart';

class App extends StatelessWidget {
  final Router _router = new Router();

  App() {
    final AuthManager authManager = new AuthManager();
    final AccountsManager accountsManager = new AccountsManager(authManager);
    Routes.configureRoutes(_router, authManager, accountsManager);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (context) => Strings.of(context).appTitle(),
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

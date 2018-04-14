import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:monzo_client/app_component.dart';
import 'package:monzo_client/strings.dart';
import 'package:monzo_client/ui/config/theme.dart';
import 'package:monzo_client/ui/config/routes.dart';

class App extends StatelessWidget {
  final AppComponent _appComponent = null; // todo

  App() {
    Routes.configureRoutes(_appComponent);
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
      onGenerateRoute: _appComponent.router().generator,
    );
  }
}

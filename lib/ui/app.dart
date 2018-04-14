import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:monzo_flutter/app_component.dart';
import 'package:monzo_flutter/strings.dart';
import 'package:monzo_flutter/ui/config/theme.dart';
import 'package:monzo_flutter/ui/config/routes.dart';

class App extends StatelessWidget {
  final AppComponent appComponent;

  App(this.appComponent) {
    Routes.configureRoutes(appComponent);
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
      onGenerateRoute: appComponent.router().generator,
    );
  }
}

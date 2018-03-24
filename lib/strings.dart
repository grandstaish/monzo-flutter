import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'i18n/monzo_messages_all.dart';

// Information about how this file relates to i18n/stock_messages_all.dart and
// how the i18n files were generated can be found in i18n/regenerate.md.

class Strings {
  Strings(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  static Future<Strings> load(Locale locale) {
    return initializeMessages(locale.toString()).then((Object _) {
      return new Strings(locale);
    });
  }

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  String appTitle() => Intl.message(
    'Monzo',
    name: 'appTitle',
    desc: 'Title for the Monzo application',
    locale: _localeName,
  );

  String sharedContinueButton() => Intl.message(
    'CONTINUE',
    name: 'sharedContinueButton',
    desc: 'Continue button text',
    locale: _localeName,
  );

  String onboardingLoginButton() => Intl.message(
    'I ALREADY HAVE A MONZO ACCOUNT',
    name: 'onboardingLoginButton',
    desc: 'Login button on the onboarding screen',
    locale: _localeName,
  );
}

class StocksLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  bool shouldReload(StocksLocalizationsDelegate old) => false;
}

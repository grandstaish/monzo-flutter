import 'package:flutter/material.dart';
import 'package:monzo_flutter/ui/config/palette.dart';

class MonzoTheme {
  static ThemeData dark = new ThemeData(
    brightness: Brightness.dark,
    primaryColor: Palette.skyBlue,
    accentColor: Palette.coral,
    backgroundColor: Palette.darkBlue,
    buttonTheme: thickerButtonTheme
  );

  static ThemeData light = new ThemeData(
      brightness: Brightness.light,
      primaryColor: Palette.skyBlue,
      accentColor: Palette.coral,
      backgroundColor: Palette.white,
      buttonTheme: thickerButtonTheme
  );

  static ButtonThemeData thickerButtonTheme = new ButtonThemeData(height: 40.0);
}

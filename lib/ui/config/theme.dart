import 'package:flutter/material.dart';
import 'package:monzo_client/ui/config/palette.dart';

class MonzoTheme {
  static ThemeData dark = new ThemeData(
    brightness: Brightness.dark,
    primaryColor: Palette.skyBlue,
    accentColor: Palette.coral,
    backgroundColor: Palette.darkBlue,
  );

  static ThemeData light = new ThemeData(
      brightness: Brightness.light,
      primaryColor: Palette.skyBlue,
      accentColor: Palette.coral,
      backgroundColor: Palette.white
  );
}

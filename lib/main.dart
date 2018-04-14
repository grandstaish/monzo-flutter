import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monzo_flutter/app_component.dart';
import 'package:monzo_flutter/app_module.dart';
import 'package:monzo_flutter/ui/app.dart';

Future<Null> main() async {
  var appComponent = await AppComponent.create(new AppModule());
  runApp(new App(appComponent));
}

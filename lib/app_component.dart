import 'package:inject/inject.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/app_module.dart';
import 'package:monzo_client/ui/splash.dart';
import 'package:monzo_client/ui/home/home.dart';
import 'package:monzo_client/ui/login/login.dart';

import 'app_component.inject.dart' as generated;

@Injector(const [AppModule])
abstract class AppComponent {
  static final create = generated.AppComponent$Injector.create;

  @provide
  Router router();

  @provide
  Splash splash();

  @provide
  Home home();

  @provide
  Login login();
}

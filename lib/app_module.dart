import 'package:inject/inject.dart';
import 'package:fluro/fluro.dart';

@module
class AppModule {
  @provide
  @singleton
  Router provideRouter() => new Router();
}

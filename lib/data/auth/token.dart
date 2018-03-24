import 'package:meta/meta.dart';

@immutable
class Token {
  final String accessToken;
  final DateTime expiresAt;

  Token(this.accessToken, this.expiresAt);
}

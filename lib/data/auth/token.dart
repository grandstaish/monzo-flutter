import 'package:meta/meta.dart';

@immutable
class Token {
  final String accessToken;
  final DateTime expiresAt;

  Token({
    @required this.accessToken,
    @required this.expiresAt
  }) : assert(accessToken != null),
       assert(expiresAt != null);

  factory Token.newToken(String accessToken, int milliseconds) {
    var expiresAt = DateTime.now().add(new Duration(milliseconds: milliseconds));
    return new Token(
        accessToken: accessToken,
        expiresAt: expiresAt
    );
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:monzo_client/data/storage.dart';
import 'token.dart';
import 'dart:async';

const accessTokenKey = 'accessToken';
const expiresAtKey = 'expiresAt';

class TokenStorage implements Storage<Token> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<Token> getValue() async {
    SharedPreferences prefs = await _prefs;
    String accessToken = prefs.getString(accessTokenKey);
    if (accessToken != null) {
      String expiresAtString = prefs.getString(expiresAtKey);
      DateTime expiresAt = DateTime.parse(expiresAtString);
      return new Token(accessToken: accessToken, expiresAt: expiresAt);
    }
    return null;
  }

  @override
  Future<Null> setValue(Token value) async {
    SharedPreferences prefs = await _prefs;
    String accessToken = value?.accessToken;
    String expiresAtString = value?.expiresAt?.toIso8601String();
    prefs.setString(accessTokenKey, accessToken);
    prefs.setString(expiresAtKey, expiresAtString);
  }
}

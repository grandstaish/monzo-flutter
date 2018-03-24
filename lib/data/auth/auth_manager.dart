import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:monzo_client/data/storage.dart';
import 'package:monzo_client/data/auth/token_storage.dart';
import 'package:monzo_client/data/auth/token.dart';
import 'package:monzo_client/keys.dart';

class AuthManager {
  bool get initialized => _initialized;

  bool get loggedIn => _loggedIn;

  OauthClient get oauthClient => _oauthClient;

  final String _clientId = CLIENT_ID;
  final String _clientSecret = CLIENT_SECRET;
  final Client _client = new Client();
  final Storage<Token> _tokenStorage = new TokenStorage();

  bool _initialized;
  bool _loggedIn;
  OauthClient _oauthClient;

  Future init() async {
    Token oauthToken = await _tokenStorage.getValue();

    if (oauthToken == null) {
      _loggedIn = false;
      await logout();
    } else {
      _loggedIn = true;
      _oauthClient = new OauthClient(_client, oauthToken.accessToken);
    }

    _initialized = true;
  }

  Future<bool> login(String username, String password) async {
    var basicToken = _getEncodedAuthorization(username, password);
    final requestHeader = {
      'Authorization': 'Basic $basicToken'
    };
    final requestBody = JSON.encode({
      'client_id': _clientId,
      'client_secret': _clientSecret
    });

    final loginResponse = await _client.post(
        'https://api.github.com/authorizations',
        headers: requestHeader,
        body: requestBody)
        .whenComplete(_client.close);

//    if (loginResponse.statusCode == 201) {
//      final bodyJson = JSON.decode(loginResponse.body);
//      await _saveToken(username, bodyJson['token']);
//      _loggedIn = true;
//    } else {
//      _loggedIn = false;
//    }

    return _loggedIn;
  }

  Future logout() async {
    await _saveToken(null);
    _loggedIn = false;
  }

  String _getEncodedAuthorization(String username, String password) {
    final authorizationBytes = UTF8.encode('$username:$password');
    return BASE64.encode(authorizationBytes);
  }

  Future _saveToken(Token oauthToken) async {
    await _tokenStorage.setValue(oauthToken);
    _oauthClient = new OauthClient(_client, oauthToken?.accessToken);
  }
}

class OauthClient extends _AuthClient {
  OauthClient(Client client, String token) : super(client, 'token $token');
}

abstract class _AuthClient extends BaseClient {
  final Client _client;
  final String _authorization;

  _AuthClient(this._client, this._authorization);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = _authorization;
    return _client.send(request);
  }
}

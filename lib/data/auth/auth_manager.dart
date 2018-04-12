import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart';
import 'package:monzo_client/data/storage.dart';
import 'package:monzo_client/data/auth/token_storage.dart';
import 'package:monzo_client/data/auth/token.dart';
import 'package:monzo_client/keys.dart';

class AuthManager {
  static const String _redirectUrl = 'https://bradcampbell.nz/monzoflutter/-magic-auth/';
  static const String _clientId = CLIENT_ID;
  static const String _clientSecret = CLIENT_SECRET;

  bool get initialized => _initialized;

  bool get loggedIn => _loggedIn;

  OauthClient get oauthClient => _oauthClient;

  final Client _client = new Client();
  final Storage<Token> _tokenStorage = new TokenStorage();

  bool _initialized;
  bool _loggedIn;
  OauthClient _oauthClient;
  String _state;

  Future<Null> init() async {
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

  String get authUrl {
    var uuid = new Uuid();
    _state = uuid.v4();
    return "https://auth.monzo.com/?client_id=$_clientId" +
        "&redirect_uri=$_redirectUrl&response_type=code&state=$_state";
  }

  Future<bool> login(String redirectUri) async {
    var uri = Uri.parse(redirectUri);
    var code = uri.queryParameters['code'];
    var state = uri.queryParameters['state'];

    if (state != _state) {
      return false;
    }

    final requestBody = <String, String>{
      'grant_type': 'authorization_code',
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'redirect_uri': _redirectUrl,
      'code': code
    };

    final loginResponse = await _client
        .post('https://api.monzo.com/oauth2/token', body: requestBody)
        .whenComplete(_client.close);

    if (loginResponse.statusCode == 200) {
      final bodyJson = json.decode(loginResponse.body);
      var accessToken = bodyJson['access_token'];
      var expiresIn = bodyJson['expires_in'];
      await _saveToken(Token.newToken(accessToken, expiresIn));
      _loggedIn = true;
    } else {
      _loggedIn = false;
    }

    return _loggedIn;
  }

  Future<Null> logout() async {
    await _saveToken(null);
    _loggedIn = false;
  }

  Future<Null> _saveToken(Token oauthToken) async {
    await _tokenStorage.setValue(oauthToken);
    _oauthClient = new OauthClient(_client, oauthToken?.accessToken);
  }
}

class OauthClient extends _AuthClient {
  OauthClient(Client client, String token) : super(client, 'Bearer $token');
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

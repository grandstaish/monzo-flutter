import 'dart:async';
import 'dart:convert';
import 'package:inject/inject.dart';
import 'package:monzo_flutter/data/auth/auth_manager.dart';
import 'package:monzo_flutter/data/accounts/accounts.dart';
import 'package:monzo_flutter/data/serializers.dart';

@provide
class AccountsManager {
  final AuthManager _authManager;

  AccountsManager(this._authManager);

  Future<AccountsResponse> loadAccounts() async {
    var oauthClient = _authManager.oauthClient;
    var response = await oauthClient.get('https://api.monzo.com/accounts');
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return serializers.deserializeWith(AccountsResponse.serializer, decoded);
    } else {
      throw new Exception('Could not get accounts');
    }
  }
}

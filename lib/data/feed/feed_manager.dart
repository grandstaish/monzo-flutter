import 'package:inject/inject.dart';
import 'package:monzo_flutter/data/auth/auth_manager.dart';

@provide
class FeedManager {
  final AuthManager _authManager;

  FeedManager(this._authManager);

//  Future<> loadFeed() async {
//
//  }
}

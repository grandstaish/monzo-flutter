import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_client/data/auth/auth_manager.dart';
import 'package:monzo_client/data/accounts/accounts_manager.dart';
import 'package:monzo_client/ui/config/routes.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
    @required this.router,
    @required this.authManager,
    @required this.accountsManager
  }) : assert(router != null),
        assert(authManager != null),
        super(key: key);

  final Router router;
  final AuthManager authManager;
  final AccountsManager accountsManager;

  void _loadAccounts() async {
    var response = await accountsManager.loadAccounts();
    print(response);
  }

  void _logout(BuildContext context) async {
    await authManager.logout();
    // No transition
    var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return child;
    };
    router.navigateTo(
        context,
        Routes.root,
        replace: true,
        transitionDuration: const Duration(milliseconds: 0),
        transition: TransitionType.custom,
        transitionBuilder: transition
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new RaisedButton(
                    onPressed: _loadAccounts,
                    child: new Text("Load accounts")
                ),
              ),
              new RaisedButton(
                  onPressed: () { _logout(context); },
                  child: new Text("Logout")
              ),
            ],
          ),
        )
    );
  }
}

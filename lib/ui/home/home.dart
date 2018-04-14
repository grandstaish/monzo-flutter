import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monzo_flutter/data/auth/auth_manager.dart';
import 'package:monzo_flutter/data/accounts/accounts_manager.dart';
import 'package:monzo_flutter/ui/config/routes.dart';

class Home extends StatelessWidget {
  final Router router;
  final AuthManager authManager;
  final AccountsManager accountsManager;

  @provide
  Home(this.router, this.authManager, this.accountsManager);

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

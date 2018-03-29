import 'package:flutter/material.dart';

typedef void ActionCallback(BuildContext stock);

class ActionButtons extends StatelessWidget {
  ActionButtons({
    Key key,
    this.primaryButtonText,
    this.primaryButtonHandler,
    this.secondaryButtonText,
    this.secondaryButtonHandler
  }) : super(key: key);

  final String primaryButtonText;

  final ActionCallback primaryButtonHandler;

  final String secondaryButtonText;

  final ActionCallback secondaryButtonHandler;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: new RaisedButton(
                onPressed: () => primaryButtonHandler(context),
                child: new Text(primaryButtonText),
              ),
            ),
            new FlatButton(
                onPressed: () => secondaryButtonHandler(context),
                child: new Text(secondaryButtonText)
            )
          ]
      ),
    );
  }
}

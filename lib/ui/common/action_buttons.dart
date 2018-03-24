import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  ActionButtons({
    this.primaryButtonText,
    this.primaryButtonHandler,
    this.secondaryButtonText,
    this.secondaryButtonHandler
  });

  final String primaryButtonText;

  final VoidCallback primaryButtonHandler;

  final String secondaryButtonText;

  final VoidCallback secondaryButtonHandler;

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
                onPressed: primaryButtonHandler,
                child: new Text(primaryButtonText),
              ),
            ),
            new FlatButton(
                onPressed: secondaryButtonHandler,
                child: new Text(secondaryButtonText)
            )
          ]
      ),
    );
  }
}

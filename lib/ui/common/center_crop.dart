import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CenterCrop extends StatelessWidget {
  CenterCrop({
    Key key,
    @required this.size,
    @required this.child
  }) : assert(size != null),
       assert(child != null),
       super(key: key);

  final Size size;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new ClipRect(
        child: new OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            alignment: Alignment.center,
            child: new FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: new Container(
                    width: size.width,
                    height: size.height,
                    child: child
                )
            )
        )
    );
  }
}

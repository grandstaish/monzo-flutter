import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monzo_client/ui/common/video/video_player.dart';

class CenterCropVideo extends StatefulWidget {
  final VideoPlayerController controller;

  CenterCropVideo(this.controller);

  @override
  _CenterCropVideoState createState() => new _CenterCropVideoState();
}

class _CenterCropVideoState extends State<CenterCropVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
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
                  child: new VideoPlayer(controller)
              )
          )
        )
      );
    } else {
      return new Container();
    }
  }
}

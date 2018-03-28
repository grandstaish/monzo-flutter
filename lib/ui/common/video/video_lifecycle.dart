import 'package:flutter/material.dart';
import 'package:monzo_client/ui/common/video/video_player.dart';
import 'package:meta/meta.dart';

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

/// A widget connecting its lifecycle to a [VideoPlayerController].
class VideoPlayerLifecycle extends StatefulWidget {
  final VideoWidgetBuilder childBuilder;
  final String asset;
  final bool isLooping;

  VideoPlayerLifecycle({
    Key key,
    @required this.asset,
    @required this.childBuilder,
    this.isLooping
  }) : assert(asset != null),
       assert(childBuilder != null),
       super(key: key);

  @override
  _VideoPlayerLifecycleState createState() {
    return new _VideoPlayerLifecycleState();
  }
}

class _VideoPlayerLifecycleState extends State<VideoPlayerLifecycle> {
  VideoPlayerController controller;

  _VideoPlayerLifecycleState();

  @override
  void initState() {
    super.initState();
    controller = new VideoPlayerController.asset(widget.asset);
    controller.addListener(() {
      if (!mounted) {
        return;
      }
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
      if (controller.value.initialized && !controller.value.isPlaying) {
        setState(() {
          // Auto-play when the player is ready.
          controller.play();
        });
      }
    });
    controller.initialize();
    controller.setLooping(widget.isLooping);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }
}

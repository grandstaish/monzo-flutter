import 'package:flutter/material.dart';
import 'package:monzo_client/ui/common/video/video_player.dart';

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

/// A widget connecting its lifecycle to a [VideoPlayerController].
class SimpleVideoPlayer extends StatefulWidget {
  final VideoWidgetBuilder childBuilder;
  final String asset;
  final bool isLooping;

  SimpleVideoPlayer(this.asset, this.childBuilder, {this.isLooping});

  @override
  _SimpleVideoPlayerState createState() {
    return new _SimpleVideoPlayerState();
  }
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  VideoPlayerController controller;

  _SimpleVideoPlayerState();

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

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:pod_player/pod_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class PlayVideoFromNetwork extends StatefulWidget {
  static const routeName = '/fromNetwork';
  final int courseId;
  final int? lessonId;
  final String videoUrl;
  const PlayVideoFromNetwork({Key? key, required this.courseId, this.lessonId, required this.videoUrl})
      : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromAssetState();
}

class _PlayVideoFromAssetState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;

  Timer? timer;

  @override
  void initState() {
    controller = PodPlayerController(
      podPlayerConfig: PodPlayerConfig(
        isLooping: false,
      ),
      playVideoFrom: PlayVideoFrom.networkQualityUrls(
        videoUrls: [
          VideoQalityUrls(
            quality: 360,
            url: widget.videoUrl,
          ),
          VideoQalityUrls(
            quality: 720,
            url: widget.videoUrl,
          ),
        ],
      ),
    )..initialise();
    super.initState();

    // if (widget.lessonId != null) {
    //   timer = Timer.periodic(
    //       const Duration(seconds: 5), (Timer t) => updateWatchHistory());
    // }
  }

  @override
  void dispose() {
    controller.dispose();
    // if (widget.lessonId != null) {
    //   timer!.cancel();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: PodVideoPlayer(
            controller: controller,
            alwaysShowProgressBar: true,
            podProgressBarConfig: const PodProgressBarConfig(
              padding: kIsWeb
                  ? EdgeInsets.zero
                  : EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
              playingBarColor: Colors.blue,
              circleHandlerColor: Colors.blue,
              backgroundColor: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}

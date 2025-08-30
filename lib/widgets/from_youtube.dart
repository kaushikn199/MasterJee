import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import '../constants.dart';

class PlayVideoFromYoutube extends StatefulWidget {
  static const routeName = '/fromVimeoId';
  final int courseId;
  final int? lessonId;
  final String videoUrl;
  const PlayVideoFromYoutube({Key? key, required this.courseId, this.lessonId, required this.videoUrl})
      : super(key: key);

  @override
  State<PlayVideoFromYoutube> createState() => _PlayVideoFromYoutubeState();
}

class _PlayVideoFromYoutubeState extends State<PlayVideoFromYoutube> {
  late final PodPlayerController controller;
  final videoTextFieldCtr = TextEditingController();

  Timer? timer;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
        isLooping: false,
        videoQualityPriority: [1080, 720, 480, 360],
      ),
    )..initialise();
    super.initState();

    // if (widget.lessonId != null) {
    //   timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => updateWatchHistory());
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
      body: SafeArea(
        child: Center(
          child: PodVideoPlayer(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class PlayVideoFromVimeoId extends StatefulWidget {
  static const routeName = '/fromVimeoId';
  final int courseId;
  final int? lessonId;
  final String vimeoVideoId;
  const PlayVideoFromVimeoId({Key? key, required this.courseId, this.lessonId, required this.vimeoVideoId})
      : super(key: key);

  @override
  State<PlayVideoFromVimeoId> createState() => _PlayVideoFromVimeoIdState();
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoFromVimeoId> {
  late final PodPlayerController controller;
  final videoTextFieldCtr = TextEditingController();

  Timer? timer;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo(widget.vimeoVideoId),
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
          child: PodVideoPlayer(controller: controller),
        ),
      ),
    );
  }
}

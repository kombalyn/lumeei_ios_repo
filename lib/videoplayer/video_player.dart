// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:apptvshow/videoplayer/controls.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
// import 'package:iptv/presentation/screens/screens.dart';
// import 'package:iptv/repository/models/channel_live.dart';
// import 'package:iptv/videoplayer/controls.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:video_player/video_player.dart';
////////
///

class VaidoPlayer extends StatefulWidget {
  const VaidoPlayer({
    super.key,
    this.chUrl,
    this.iconSize = 20,
    this.fontSize = 12,
    this.userAgent,
    // this.channelLive,
    this.name,
    this.images,
  });
  final double iconSize;
  final double fontSize;
  // ignore: prefer_typing_uninitialized_variables
  final chUrl;
  final userAgent;
  final name;
  final images;

  // final ChannelLive? channelLive;
  @override
  State<VaidoPlayer> createState() => _VaidoPlayerState();
}

class _VaidoPlayerState extends State<VaidoPlayer> {
  late FlickManager flickManager;

  // late VideoPlayerController _controller;
  // ignore: prefer_typing_uninitialized_variables
  var aa;
  @override
  void initState() {
    // print("++++++++++++++++++++++++++++++++++++++++++++++");

    // print(widget.chUrl);
    // print(widget.images);
    // print("++++++++++++++++++++++++++++++++++++++++++++++");

    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        "${widget.chUrl}",
      ),
    );
  }

  // late VideoPlayerController _videoPlayerController;
  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        Navigator.pop(context);
        // start = true;
        return true;
      },
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: FlickVideoPlayer(
          flickManager: flickManager,
          preferredDeviceOrientation: const [
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ],
          // ignore: prefer_const_literals_to_create_immutables
          systemUIOverlay: [],
          flickVideoWithControls: FlickVideoWithControls(
            playerErrorFallback: const Center(
              child: Text(
                'Error',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            playerLoadingFallback: const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
            videoFit: BoxFit.fill,
            controls: LandscapePlayerControls(
              aa: widget.chUrl,
              user: widget.name,
            ),
          ),
        ),
      ),
    );
  }
}

// 
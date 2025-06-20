// ignore_for_file: prefer_const_constructors, prefer_final_fields, deprecated_member_use, prefer_typing_uninitialized_variables, file_names

import 'package:apptvshow/ads/adsWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayer extends StatefulWidget {
  // static const customSwatch = MaterialColor(
  //   0xFFFF5252,
  //   <int, Color>{
  //     50: Color(0xFFFFEBEE),
  //     100: Color(0xFFFFCDD2),
  //     200: Color(0xFFEF9A9A),
  //     300: Color(0xFFE57373),
  //     400: Color(0xFFEF5350),
  //     500: Color(0xFFFF5252),
  //     600: Color(0xFFE53935),
  //     700: Color(0xFFD32F2F),
  //     800: Color(0xFFC62828),
  //     900: Color(0xFFB71C1C),
  //   },
  // );

  const YouTubePlayer({Key? key, this.videoid}) : super(key: key);
  final videoid;

  @override
  State<YouTubePlayer> createState() => _MyApp33State();
}

class _MyApp33State extends State<YouTubePlayer> {
  // YoutubePlayerController? _controller;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoid,
      autoPlay: false,
      params: const YoutubePlayerParams(
          showFullscreenButton: true, enableJavaScript: true),
    );
    // _controller = YoutubePlayerController(
    //   initialVideoId:
    //       widget.chid, // https://www.youtube.com/watch?v=Tb9k9_Bo-G4
    //   flags: YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //     isLive: false,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

        return true;
      },
      child: MaterialApp(
        theme: ThemeData(
            // primarySwatch: YouTubePlayer.customSwatch,
            ),
        debugShowCheckedModeBanner: false,
        home: YoutubePlayerScaffold(
          controller: _controller,
          aspectRatio: 16 / 9,
          builder: (context, player) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                player,
                AdsFuture(),
              ],
            );
          },
        ),
      ),
    );
  }
}

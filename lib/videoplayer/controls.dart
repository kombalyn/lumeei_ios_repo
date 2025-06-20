// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore, must_be_immutable

import 'package:apptvshow/dlna/dlna.dart';
import 'package:apptvshow/videoplayer/landscapePlayToggle.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

class LandscapePlayerControls extends StatelessWidget {
  LandscapePlayerControls({
    Key? key,
    this.iconSize = 20,
    this.fontSize = 12,
    required this.aa,
    this.user,
  }) : super(key: key);
  final double iconSize;
  final double fontSize;
  // ignore: prefer_typing_uninitialized_variables
  final aa;
  final user;
  // ignore: prefer_typing_uninitialized_variables
  double speed = 5.0;
  late FlickControlManager controlManager2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: LandscapePlayToggle(),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color.fromRGBO(0, 0, 0, 0.4).withOpacity(0.2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const FlickPlayToggle(
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FlickCurrentPosition(
                        fontSize: fontSize,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // ignore: avoid_unnecessary_containers
                        child: Container(
                          child: FlickVideoProgressBar(
                            flickProgressBarSettings: FlickProgressBarSettings(
                              height: 10,
                              handleRadius: 10,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8,
                              ),
                              backgroundColor: Colors.white24,
                              bufferedColor: Colors.transparent,
                              getPlayedPaint: (
                                  {double? handleRadius,
                                  double? height,
                                  double? playedPart,
                                  double? width}) {
                                return Paint()
                                  ..shader = const LinearGradient(
                                      colors: [Colors.red, Colors.white],
                                      stops: [0.0, 0.5]).createShader(
                                    Rect.fromPoints(
                                      // ignore: prefer_const_constructors
                                      Offset(0, 0),
                                      Offset(width!, 0),
                                    ),
                                  );
                              },
                              getHandlePaint: (
                                  {double? handleRadius,
                                  double? height,
                                  double? playedPart,
                                  double? width}) {
                                return Paint()
                                  ..shader = const RadialGradient(
                                    colors: [
                                      Color.fromRGBO(97, 104, 236, 1),
                                      Color.fromRGBO(97, 104, 236, 1),
                                      Colors.black,
                                    ],
                                    stops: [0.0, 0.4, 0.5],
                                    radius: 0.4,
                                  ).createShader(
                                    Rect.fromCircle(
                                      center: Offset(playedPart!, height! / 2),
                                      radius: handleRadius!,
                                    ),
                                  );
                              },
                            ),
                          ),
                        ),
                      ),
                      // FlickTotalDuration(
                      //   fontSize: fontSize,
                      // ),
                      // FlickSetPlayBack(
                      //   setPlayBack: (speed) {},

                      //   speed: 5.5, // You can set the default speed here.
                      // ),

                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 10,
                      ),
                      const FlickSoundToggle(
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 10,
          child: GestureDetector(
            onTap: () async {
              // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              //     overlays: SystemUiOverlay.values);
              // SystemChrome.setPreferredOrientations(
              //     [DeviceOrientation.portraitUp]);
              // Navigator.pop(context);
              // await AppLauncher.openApp(
              //   androidApplicationId: "com.instantbits.cast.webvideo",
              // );
              // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              //     overlays: SystemUiOverlay.values);
              // SystemChrome.setPreferredOrientations(
              //     [DeviceOrientation.portraitUp]);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return DlnaDeviceList(
                  booll: true,
                  videoId: aa,
                  user: user,
                );
              }));
            },

            child: Image.asset(
              'images/dlna.png',
              color: Colors.white,
              width: 30,
              height: 30,
            ),

            //  Row(
            //   children: [
            //     Icon(
            //       Icons.cancel,
            //       size: 30,
            //     ),
            //     Icon(
            //       Icons.cancel,
            //       size: 30,
            //     ),
            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}

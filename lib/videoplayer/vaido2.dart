// // ignore_for_file: override_on_non_overriding_member, unused_field, prefer_typing_uninitialized_variables, library_private_types_in_public_api, unused_element, prefer_final_fields, deprecated_member_use, unnecessary_string_interpolations

// import 'dart:async';
// import 'dart:io';
// // import 'dart:io';

// import 'package:apptvshow/dlna/dlna.dart';
// import 'package:apptvshow/modelview/viewHome.dart';
// import 'package:apptvshow/screen/tvShow.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:filling_slider/filling_slider.dart';
// import 'package:floating/floating.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// // import 'package:iptv/dlna/dlna.dart';

// // import 'package:iptv/helpers/helpers.dart';
// // import 'package:iptv/logic/cubits/video/video_cubit.dart';
// // import 'package:iptv/presentation/screens/screens.dart';
// // // import 'package:iptv/presentation/screens/welcome.dart';
// // import 'package:iptv/presentation/widgets/player.dart';
// // import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:perfect_volume_control/perfect_volume_control.dart';
// // import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:screen_brightness/screen_brightness.dart';
// import 'package:video_player/video_player.dart';
// // ignore: depend_on_referenced_packages
// import 'package:wakelock/wakelock.dart';

// /// Stateful widget to fetch and then display video content.
// class VideoApp22 extends StatefulWidget {
//   const VideoApp22({
//     super.key,
//     this.link,
//     this.userAgent,
//   });
//   final link;
//   final userAgent;
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp22> {
//   ViewHome viewHome = Get.put(ViewHome());
//   late VideoPlayerController controller2;
//   final floating = Floating();
//   bool showControllersVideo = true;
//   double sliderValue = 0.0;
//   bool progress = true;
//   // bool isLive = true;
//   bool validPosition = false;
//   String position = '';
//   String duration = '';
//   late Timer timer;
//   late Timer timer2;
//   bool error = false;
//   bool cast = false;
//   bool isPlayed = true;
//   double _currentVolume = 0.2;
//   double _currentBright = 0.2;
//   late Future<void> _initializeVideoPlayerFuture;
//   double _currentSliderValue = 0.0;
//   @override
//   void initState() {
//     // SystemChrome.setPreferredOrientations([
//     //   DeviceOrientation.landscapeLeft,
//     //   DeviceOrientation.landscapeRight,
//     // ]);
//     // WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
//     super.initState();
//     // controller2.videoPlayerOptions
//     Wakelock.enable();
//     // controller2;
//     // controller2.play();
//     controller2 = VideoPlayerController.networkUrl(
//       httpHeaders: {"User-Agent": widget.userAgent},
//       Uri.parse(
//         widget.link,
//       ),
//     )..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });

//     controller2.play();
//     controller2.addListener(listener);
//     timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       if (showControllersVideo) {
//         setState(() {
//           showControllersVideo = false;
//         });
//       }
//     });
//     timer2 = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (lisner) {
//         // setState(() {
//         // error = true;
//         // x = controller2.value.hasError;
//         lisner = false;
//         controller2.addListener(listener);
//         // });
//         // x = controller2.value.hasError;
//       }
//     });
//     controller2.addListener(listener);
//     // controller2.addListener(() {
//     //   setState(() {
//     //     _currentSliderValue =
//     //         controller2.value.position.inMilliseconds.toDouble();
//     //   });
//     // });
//   }

//   listener() async {
//     if (!mounted) return;

//     if (progress) {
//       if (controller2.value.isPlaying) {
//         setState(() {
//           progress = false;
//         });
//       }
//     }

//     if (controller2.value.isInitialized) {
//       var oPosition = controller2.value.position;
//       var oDuration = controller2.value.duration;

//       if (oDuration.inHours == 0) {
//         var strPosition = oPosition.toString().split('.')[0];
//         var strDuration = oDuration.toString().split('.')[0];
//         position = "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
//         duration = "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
//       } else {
//         position = oPosition.toString().split('.')[0];
//         duration = oDuration.toString().split('.')[0];
//       }
//       validPosition = oDuration.compareTo(oPosition) >= 0;
//       sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0.0;
//       setState(() {
//         // sliderValue = controller2.value.position.inSeconds.toDouble();
//       });
//     }
//   }

//   void _onSliderPositionChanged(double progress) {
//     setState(() {
//       sliderValue =
//           controller2.seekTo(Duration(seconds: progress.toInt())) as double;
//       // controller2.seekTo(Duration(seconds: progress.toInt()));
//     });
//     // convert to Milliseconds since VLC requires MS to set time
//     // controller2.setTime(sliderValue.toInt() * 1000);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
//     if (lifecycleState == AppLifecycleState.inactive) {
//       floating.enable(aspectRatio: const Rational.square());
//     }
//   }

//   Future<void> enablePip() async {
//     final status =
//         await floating.enable(aspectRatio: const Rational.landscape());
//     debugPrint('PiP enabled? $status');
//   }

//   double _playbackSpeed = 5.0;
//   double _playbackSpeed2 = 1.0;
//   double _playbackSpeed222 = -5.0;
//   double _playbackSpeed22 = 1.0;

//   bool a = true;
//   bool b = true;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//             overlays: SystemUiOverlay.values);
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//         // Navigator.pop(context);
//         controller2.dispose();
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Ink(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadiusDirectional.circular(25),
//                   color: Colors.black,
//                 ),
//                 // width: getSize(context).width,
//                 // height: getSize(context).height,
//                 child: controller2.value.isInitialized
//                     ? AspectRatio(
//                         aspectRatio: 16 / 9,
//                         child: VideoPlayer(
//                           controller2,
//                         ),
//                       )
//                     : Center(
//                         child: controller2.value.hasError
//                             ? const Text(
//                                 'Error',
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.yellow),
//                               )
//                             : const CircularProgressIndicator(),
//                       ),
//               ),

//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     // context.read<VideoCubit>().changeUrlVideo(true);
//                     showControllersVideo = !showControllersVideo;
//                   });
//                 },
//                 child: controller2.value.isInitialized
//                     ? Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         // width: getSize(context).width,
//                         // height: getSize(context).height,
//                         color: Colors.transparent,
//                         child: AnimatedSize(
//                           duration: const Duration(milliseconds: 200),
//                           child: !showControllersVideo
//                               ? const SizedBox()
//                               : SafeArea(
//                                   child: Stack(
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           ///Back & Title
//                                           const Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               // IconButton(
//                                               //   focusColor: kColorFocus,
//                                               //   onPressed: () async {
//                                               //     await Future.delayed(
//                                               //             const Duration(
//                                               //                 milliseconds: 1000))
//                                               //         .then((value) {
//                                               //       Get.back(
//                                               //           result: progress
//                                               //               ? null
//                                               //               : [
//                                               //                   sliderValue,
//                                               //                   widget
//                                               //                       .controller2
//                                               //                       .value
//                                               //                       .duration
//                                               //                       .inSeconds
//                                               //                       .toDouble()
//                                               //                 ]);
//                                               //     });
//                                               //   },
//                                               //   icon: Icon(
//                                               //       FontAwesomeIcons.chevronLeft,
//                                               //       color: Colors.white,
//                                               //       size: 19),
//                                               // ),
//                                               SizedBox(width: 5),
//                                               // Expanded(
//                                               //   child: Text(
//                                               //     widget.title,
//                                               //     maxLines: 1,
//                                               //     style:
//                                               //         Get.textTheme.labelLarge!.copyWith(
//                                               //       color: Colors.white,
//                                               //       fontWeight: FontWeight.bold,
//                                               //       fontSize: 18.sp,
//                                               //     ),
//                                               //   ),
//                                               // ),
//                                               // Row(
//                                               //   children: [
//                                               //     Container(
//                                               //       decoration: BoxDecoration(
//                                               //         color: Colors.black
//                                               //             .withOpacity(0.3),
//                                               //         borderRadius:
//                                               //             BorderRadius.circular(
//                                               //                 25),
//                                               //       ),
//                                               //       child: GestureDetector(
//                                               //         onTap: () {
//                                               //           // start = true;
//                                               //           controller2
//                                               //               .pause();

//                                               //           Get.to(DlnaDeviceList(
//                                               //             booll: true,
//                                               //             videoId: widget.link,
//                                               //           ));
//                                               //         },
//                                               //         child: Padding(
//                                               //           padding:
//                                               //               const EdgeInsets.all(
//                                               //                   8.0),
//                                               //           child: Image.asset(
//                                               //             "assets/images/dlna.png",
//                                               //             width: 30,
//                                               //             height: 30,
//                                               //             color: Colors.white,
//                                               //           ),
//                                               //         ),
//                                               //       ),
//                                               //     ),
//                                               //     Container(
//                                               //       decoration: BoxDecoration(
//                                               //         color: Colors.black
//                                               //             .withOpacity(0.3),
//                                               //         borderRadius:
//                                               //             BorderRadius.circular(
//                                               //                 25),
//                                               //       ),
//                                               //       child: IconButton(
//                                               //         onPressed: () {
//                                               //           start = true;
//                                               //           ahmedApp
//                                               //               .checkVLCInstallation2(
//                                               //                   widget.link);
//                                               //         },
//                                               //         icon: const Icon(
//                                               //           Icons.cast,
//                                               //           color: Colors.white,
//                                               //         ),
//                                               //       ),
//                                               //     )
//                                               //   ],
//                                               // )
//                                             ],
//                                           ),

//                                           ///Slider & Play/Pause
//                                           // if (!progress && isLive)
//                                           Align(
//                                             alignment: Alignment.bottomCenter,
//                                             child: Container(
//                                               color:
//                                                   Colors.white.withOpacity(0.0),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceEvenly,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             "$position",
//                                                             style: Get.textTheme
//                                                                 .titleSmall!
//                                                                 .copyWith(
//                                                                     color: Colors
//                                                                         .yellow,
//                                                                     fontSize:
//                                                                         15,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold),
//                                                           ),
//                                                           const SizedBox(
//                                                             width: 5,
//                                                           ),
//                                                           const Text(
//                                                             "/",
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white),
//                                                           ),
//                                                           const SizedBox(
//                                                             width: 5,
//                                                           ),
//                                                           Text(
//                                                             "$duration",
//                                                             style: Get.textTheme
//                                                                 .titleSmall!
//                                                                 .copyWith(
//                                                                     color: Colors
//                                                                         .yellow,
//                                                                     fontSize:
//                                                                         15,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         // mainAxisAlignment:
//                                                         //     MainAxisAlignment.end,
//                                                         children: [
//                                                           Platform.isAndroid
//                                                               ? IconButton(
//                                                                   onPressed:
//                                                                       () async {
//                                                                     bool
//                                                                         isMXInstalled =
//                                                                         await DeviceApps.isAppInstalled(
//                                                                             "com.instantbits.cast.webvideo");
//                                                                     if (isMXInstalled) {
//                                                                       controller2
//                                                                           .pause();
//                                                                       cast =
//                                                                           true;
//                                                                       isPlayed =
//                                                                           false;
//                                                                     }

//                                                                     // start = true;
//                                                                     // lisner = true;
//                                                                     viewHome.checkVLCInstallation2(
//                                                                         widget
//                                                                             .link);
//                                                                   },
//                                                                   icon:
//                                                                       const Icon(
//                                                                     Icons.cast,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 )
//                                                               : const SizedBox(),
//                                                           GestureDetector(
//                                                             onTap: () {
//                                                               // start = true;
//                                                               controller2
//                                                                   .pause();

//                                                               Get.off(
//                                                                   DlnaDeviceList(
//                                                                 booll: true,
//                                                                 videoId:
//                                                                     widget.link,
//                                                                 user: widget
//                                                                     .userAgent,
//                                                               ));
//                                                               // if (a) {
//                                                               //   controller2
//                                                               //       .setPlaybackSpeed(
//                                                               //           _playbackSpeed);
//                                                               //   a = false;
//                                                               // } else {
//                                                               //   controller2
//                                                               //       .setPlaybackSpeed(
//                                                               //           _playbackSpeed2);
//                                                               //   a = true;
//                                                               // }
//                                                             },
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8.0),
//                                                               child:
//                                                                   Image.asset(
//                                                                 "images/dlna.png",
//                                                                 width: 30,
//                                                                 height: 30,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           PiPSwitcher(
//                                                             childWhenDisabled:
//                                                                 IconButton(
//                                                               onPressed:
//                                                                   enablePip,
//                                                               icon: const Icon(
//                                                                 Icons
//                                                                     .picture_in_picture,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                             childWhenEnabled:
//                                                                 const SizedBox(),
//                                                           ),
//                                                           IconButton(
//                                                             onPressed: () {
//                                                               if (b) {
//                                                                 SystemChrome
//                                                                     .setPreferredOrientations([
//                                                                   DeviceOrientation
//                                                                       .landscapeLeft,
//                                                                   DeviceOrientation
//                                                                       .landscapeRight,
//                                                                 ]);
//                                                                 b = false;
//                                                               } else {
//                                                                 SystemChrome
//                                                                     .setPreferredOrientations([
//                                                                   DeviceOrientation
//                                                                       .portraitDown,
//                                                                   DeviceOrientation
//                                                                       .portraitUp,
//                                                                 ]);
//                                                                 b = true;
//                                                               }
//                                                             },
//                                                             icon: const Icon(
//                                                               Icons.fullscreen,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       const SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       // Image.asset(
//                                                       //   "assets/images/live.png",
//                                                       //   height: 35,
//                                                       //   width: 35,
//                                                       // ),
//                                                       // IconButton(
//                                                       //   onPressed: () {
//                                                       //     if (a) {
//                                                       //       controller2
//                                                       //           .setPlaybackSpeed(
//                                                       //               _playbackSpeed);
//                                                       //       a = false;
//                                                       //     } else {
//                                                       //       controller2
//                                                       //           .setPlaybackSpeed(
//                                                       //               _playbackSpeed2);
//                                                       //       a = true;
//                                                       //     }
//                                                       //   },
//                                                       //   icon: const Icon(
//                                                       //     Icons.speed,
//                                                       //     color: Colors.white,
//                                                       //   ),
//                                                       // ),
//                                                       // Text(
//                                                       //   "$duration",
//                                                       //   style: Get.textTheme
//                                                       //       .titleSmall!
//                                                       //       .copyWith(
//                                                       //           color: Colors
//                                                       //               .yellow,
//                                                       //           fontSize: 15,
//                                                       //           fontWeight:
//                                                       //               FontWeight
//                                                       //                   .bold),
//                                                       // ),
//                                                       Expanded(
//                                                         child: Slider(
//                                                             activeColor:
//                                                                 Colors.red,
//                                                             inactiveColor:
//                                                                 Colors.yellow,
//                                                             value: sliderValue,
//                                                             min: 0,
//                                                             max: (!validPosition)
//                                                                 ? controller2
//                                                                     .value
//                                                                     .duration
//                                                                     .inSeconds
//                                                                     .toDouble()
//                                                                 : controller2
//                                                                     .value
//                                                                     .duration
//                                                                     .inSeconds
//                                                                     .toDouble(),
//                                                             onChanged: (value) {
//                                                               if (!validPosition) {
//                                                                 _onSliderPositionChanged(
//                                                                     value);
//                                                               } else {
//                                                                 controller2.seekTo(
//                                                                     Duration(
//                                                                         seconds:
//                                                                             value.toInt()));
//                                                               }
//                                                             }

//                                                             // validPosition
//                                                             //     ? controller2.seekTo(
//                                                             //   Duration(
//                                                             //       milliseconds:
//                                                             //           value.toInt()));
//                                                             //     : null,
//                                                             ),
//                                                         //  Slider(
//                                                         //   // thumbColor: Colors.red,
//                                                         //   // activeColor: Colors.yellow,
//                                                         //   // inactiveColor: Colors.yellow,
//                                                         //   value: sliderValue,
//                                                         //   min: 0.0,
//                                                         //   max:
//                                                         // (!validPosition)
//                                                         //       ? 1.0
//                                                         //       : controller2
//                                                         //           .value.duration.inSeconds
//                                                         //           .toDouble(),
//                                                         //   onChanged: validPosition
//                                                         //       ? _onSliderPositionChanged
//                                                         //       : null,
//                                                         // ),
//                                                       ),
//                                                       // Text(
//                                                       //   " $duration",
//                                                       //   style: Get
//                                                       //       .textTheme.titleSmall!
//                                                       //       .copyWith(
//                                                       //           color: Colors.yellow,
//                                                       //           fontSize: 15.sp,
//                                                       //           fontWeight:
//                                                       //               FontWeight.bold),
//                                                       // ),
//                                                       // Text(
//                                                       //   "$position",
//                                                       //   style: Get.textTheme
//                                                       //       .titleSmall!
//                                                       //       .copyWith(
//                                                       //           color: Colors
//                                                       //               .yellow,
//                                                       //           fontSize: 15,
//                                                       //           fontWeight:
//                                                       //               FontWeight
//                                                       //                   .bold),
//                                                       // ),
//                                                       const SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       // Platform.isAndroid
//                                                       //     ? IconButton(
//                                                       //         onPressed:
//                                                       //             () async {
//                                                       //           bool
//                                                       //               isMXInstalled =
//                                                       //               await DeviceApps
//                                                       //                   .isAppInstalled(
//                                                       //                       "com.instantbits.cast.webvideo");
//                                                       //           if (isMXInstalled) {
//                                                       //             controller2
//                                                       //                 .pause();
//                                                       //             cast = true;
//                                                       //             isPlayed =
//                                                       //                 false;
//                                                       //           }

//                                                       //           // start = true;
//                                                       //           // lisner = true;
//                                                       //           viewHome
//                                                       //               .checkVLCInstallation2(
//                                                       //                   widget
//                                                       //                       .link);
//                                                       //         },
//                                                       //         icon: const Icon(
//                                                       //           Icons.cast,
//                                                       //           color: Colors
//                                                       //               .white,
//                                                       //         ),
//                                                       //       )
//                                                       //     : const SizedBox(),
//                                                       // PiPSwitcher(
//                                                       //   childWhenDisabled: IconButton(
//                                                       //     onPressed: enablePip,
//                                                       //     icon: const Icon(
//                                                       //       Icons.picture_in_picture,
//                                                       //       color: Colors.white,
//                                                       //     ),
//                                                       //   ),

//                                                       //   childWhenEnabled:
//                                                       //       const SizedBox(),
//                                                       // child:
//                                                       // GestureDetector(
//                                                       //   onTap: () {
//                                                       //     // start = true;
//                                                       //     // controller2.pause();

//                                                       //     // Get.to(DlnaDeviceList(
//                                                       //     //   booll: true,
//                                                       //     //   videoId: widget.link,
//                                                       //     // ));
//                                                       //     ghghg
//                                                       //   },
//                                                       // child:
//                                                       //  Padding(
//                                                       //   padding:
//                                                       //       const EdgeInsets.all(
//                                                       //           8.0),
//                                                       //   child: Image.asset(
//                                                       //     "assets/images/dlna.png",
//                                                       //     width: 30,
//                                                       //     height: 30,
//                                                       //     color: Colors.white,
//                                                       //   ),
//                                                       // ),
//                                                       // ),
//                                                       // GestureDetector(
//                                                       //   onTap: () {
//                                                       //     // start = true;
//                                                       //     controller2.pause();

//                                                       //     Get.off(
//                                                       //         DlnaDeviceList(
//                                                       //       booll: true,
//                                                       //       videoId:
//                                                       //           widget.link,
//                                                       //       user: widget
//                                                       //           .userAgent,
//                                                       //     ));
//                                                       //     if (a) {
//                                                       //       controller2
//                                                       //           .setPlaybackSpeed(
//                                                       //               _playbackSpeed);
//                                                       //       a = false;
//                                                       //     } else {
//                                                       //       controller2
//                                                       //           .setPlaybackSpeed(
//                                                       //               _playbackSpeed2);
//                                                       //       a = true;
//                                                       //     }
//                                                       //   },
//                                                       //   child: Padding(
//                                                       //     padding:
//                                                       //         const EdgeInsets
//                                                       //             .all(8.0),
//                                                       //     child: Image.asset(
//                                                       //       "images/dlna.png",
//                                                       //       width: 30,
//                                                       //       height: 30,
//                                                       //       color: Colors.white,
//                                                       //     ),
//                                                       //   ),
//                                                       // ),
//                                                       // PiPSwitcher(
//                                                       //   childWhenDisabled:
//                                                       //       IconButton(
//                                                       //     onPressed: enablePip,
//                                                       //     icon: const Icon(
//                                                       //       Icons
//                                                       //           .picture_in_picture,
//                                                       //       color: Colors.white,
//                                                       //     ),
//                                                       //   ),
//                                                       //   childWhenEnabled:
//                                                       //       const SizedBox(),
//                                                       // ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       // Center(
//                                       //     child: IconButton(
//                                       //   onPressed: () {
//                                       //     setState(() {
//                                       //       controller2.value.isPlaying
//                                       //           ? controller2.pause()
//                                       //           : controller2.play();
//                                       //     });
//                                       //   },
//                                       //   icon: Icon(
//                                       //     color: Colors.red,
//                                       //     controller2.value.isPlaying
//                                       //         ? Icons.pause
//                                       //         : Icons.play_arrow,
//                                       //   ),
//                                       // ))
//                                     ],
//                                   ),
//                                 ),
//                         ),
//                       )
//                     : const Text(""),
//               ),
//               // if (!progress && showControllersVideo)

//               ///Controllers Light, Lock...

//               !progress && showControllersVideo
//                   ? Align(
//                       alignment: Alignment.topRight,
//                       child: IconButton(
//                         focusColor: Colors.red,
//                         onPressed: () {
//                           // context.read<VideoCubit>().changeUrlVideo(false);
//                           // SystemChrome.setEnabledSystemUIMode(
//                           //     SystemUiMode.manual,
//                           //     overlays: SystemUiOverlay.values);
//                           // SystemChrome.setPreferredOrientations(
//                           //     [DeviceOrientation.portraitUp]);
//                           // Navigator.pop(context);
//                           controller2.dispose();
//                           Get.back();
//                         },
//                         icon: const Icon(
//                           FontAwesomeIcons.chevronRight,
//                           color: Colors.yellow,
//                         ),
//                       ),
//                     )
//                   : const Text(""),
//               // if (vlc == true)
//               controller2.value.isInitialized
//                   ? !progress && showControllersVideo
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             FillingSlider(
//                               direction: FillingSliderDirection.vertical,
//                               initialValue: _currentVolume,
//                               onFinish: (value) async {
//                                 PerfectVolumeControl.hideUI = true;
//                                 await PerfectVolumeControl.setVolume(value);
//                                 setState(() {
//                                   _currentVolume = value;
//                                 });
//                               },
//                               fillColor: Colors.white54,
//                               height: 150,
//                               width: 30,
//                               child: Icon(
//                                 _currentVolume < .1
//                                     ? FontAwesomeIcons.volumeXmark
//                                     : _currentVolume < .7
//                                         ? FontAwesomeIcons.volumeLow
//                                         : FontAwesomeIcons.volumeHigh,
//                                 color: Colors.yellow,
//                                 size: 13,
//                               ),
//                             ),
//                             Center(
//                               child: Row(
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       controller2.seekTo(Duration(
//                                           seconds: controller2
//                                                   .value.position.inSeconds -
//                                               5));
//                                     },
//                                     icon: const Icon(
//                                       Icons.fast_rewind,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         if (isPlayed) {
//                                           controller2.pause();
//                                           isPlayed = false;
//                                         } else {
//                                           if (cast) {
//                                             // start = true;
//                                             cast = false;
//                                             isPlayed = true;
//                                           } else {
//                                             controller2.play();
//                                             isPlayed = true;
//                                           }
//                                         }
//                                       });
//                                     },
//                                     icon: Icon(
//                                       color: Colors.yellow,
//                                       isPlayed
//                                           ? FontAwesomeIcons.pause
//                                           : FontAwesomeIcons.play,
//                                       size: 24,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       if (a) {
//                                         controller2
//                                             .setPlaybackSpeed(_playbackSpeed);
//                                         a = false;
//                                       } else {
//                                         controller2
//                                             .setPlaybackSpeed(_playbackSpeed2);
//                                         a = true;
//                                       }
//                                     },
//                                     icon: const Icon(
//                                       Icons.fast_forward,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             FillingSlider(
//                               initialValue: _currentBright,
//                               direction: FillingSliderDirection.vertical,
//                               fillColor: Colors.white54,
//                               height: 150,
//                               width: 30,
//                               onFinish: (value) async {
//                                 await ScreenBrightness()
//                                     .setScreenBrightness(value);
//                                 setState(() {
//                                   _currentBright = value;
//                                 });
//                               },
//                               child: Icon(
//                                 _currentBright < .1
//                                     ? FontAwesomeIcons.moon
//                                     : _currentVolume < .7
//                                         ? FontAwesomeIcons.sun
//                                         : FontAwesomeIcons.solidSun,
//                                 color: Colors.yellow,
//                                 size: 13,
//                               ),
//                             ),
//                           ],
//                         )
//                       : const Text("")
//                   : const Text(""),
//             ],
//           ),
//           // floatingActionButton: FloatingActionButton(
//           //   onPressed: () {
//           //     setState(() {
//           //       controller2.value.isPlaying
//           //           ? controller2.pause()
//           //           : controller2.play();
//           //     });
//           //   },
//           //   child: Icon(
//           //     controller2.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
//     floating.dispose();
//     super.dispose();
//     // controller2.dispose();
//     timer.cancel();
//     // timer2.cancel();
//     controller2.dispose();
//   }
// }

// // class _ControlsOverlay extends StatelessWidget {
// //   const _ControlsOverlay({required this.controller});

// //   static const List<Duration> _exampleCaptionOffsets = <Duration>[
// //     Duration(seconds: -10),
// //     Duration(seconds: -3),
// //     Duration(seconds: -1, milliseconds: -500),
// //     Duration(milliseconds: -250),
// //     Duration.zero,
// //     Duration(milliseconds: 250),
// //     Duration(seconds: 1, milliseconds: 500),
// //     Duration(seconds: 3),
// //     Duration(seconds: 10),
// //   ];
// //   static const List<double> _examplePlaybackRates = <double>[
// //     0.25,
// //     0.5,
// //     1.0,
// //     1.5,
// //     2.0,
// //     3.0,
// //     5.0,
// //     10.0,
// //   ];

// //   final VideoPlayerController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: <Widget>[
// //         AnimatedSwitcher(
// //           duration: const Duration(milliseconds: 50),
// //           reverseDuration: const Duration(milliseconds: 200),
// //           child: controller.value.isPlaying
// //               ? const SizedBox.shrink()
// //               : Container(
// //                   color: Colors.black26,
// //                   child: const Center(
// //                     child: Icon(
// //                       Icons.play_arrow,
// //                       color: Colors.white,
// //                       size: 100.0,
// //                       semanticLabel: 'Play',
// //                     ),
// //                   ),
// //                 ),
// //         ),
// //         GestureDetector(
// //           onTap: () {
// //             controller.value.isPlaying ? controller.pause() : controller.play();
// //           },
// //         ),
// //         Align(
// //           alignment: Alignment.topLeft,
// //           child: PopupMenuButton<Duration>(
// //             initialValue: controller.value.captionOffset,
// //             tooltip: 'Caption Offset',
// //             onSelected: (Duration delay) {
// //               controller.setCaptionOffset(delay);
// //             },
// //             itemBuilder: (BuildContext context) {
// //               return <PopupMenuItem<Duration>>[
// //                 for (final Duration offsetDuration in _exampleCaptionOffsets)
// //                   PopupMenuItem<Duration>(
// //                     value: offsetDuration,
// //                     child: Text('${offsetDuration.inMilliseconds}ms'),
// //                   )
// //               ];
// //             },
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(
// //                 // Using less vertical padding as the text is also longer
// //                 // horizontally, so it feels like it would need more spacing
// //                 // horizontally (matching the aspect ratio of the video).
// //                 vertical: 12,
// //                 horizontal: 16,
// //               ),
// //               child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
// //             ),
// //           ),
// //         ),
// //         Align(
// //           alignment: Alignment.topRight,
// //           child: PopupMenuButton<double>(
// //             initialValue: controller.value.playbackSpeed,
// //             tooltip: 'Playback speed',
// //             onSelected: (double speed) {
// //               controller.setPlaybackSpeed(speed);
// //             },
// //             itemBuilder: (BuildContext context) {
// //               return <PopupMenuItem<double>>[
// //                 for (final double speed in _examplePlaybackRates)
// //                   PopupMenuItem<double>(
// //                     value: speed,
// //                     child: Text('${speed}x'),
// //                   )
// //               ];
// //             },
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(
// //                 // Using less vertical padding as the text is also longer
// //                 // horizontally, so it feels like it would need more spacing
// //                 // horizontally (matching the aspect ratio of the video).
// //                 vertical: 12,
// //                 horizontal: 16,
// //               ),
// //               child: Text('${controller.value.playbackSpeed}x'),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class _PlayerVideoAndPopPage extends StatefulWidget {
// //   @override
// //   _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
// // }

// // class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
// //   late VideoPlayerController _videoPlayerController;
// //   bool startedPlaying = false;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
// //         "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
// //     _videoPlayerController.addListener(() {
// //       if (startedPlaying && !_videoPlayerController.value.isPlaying) {
// //         Navigator.pop(context);
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _videoPlayerController.dispose();
// //     super.dispose();
// //   }

// //   Future<bool> started() async {
// //     await _videoPlayerController.initialize();
// //     await _videoPlayerController.play();
// //     startedPlaying = true;
// //     return true;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Material(
// //       child: Center(
// //         child: FutureBuilder<bool>(
// //           future: started(),
// //           builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
// //             if (snapshot.data ?? false) {
// //               return AspectRatio(
// //                 aspectRatio: _videoPlayerController.value.aspectRatio,
// //                 child: VideoPlayer(_videoPlayerController),
// //               );
// //             } else {
// //               return const Text('waiting for video to load');
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

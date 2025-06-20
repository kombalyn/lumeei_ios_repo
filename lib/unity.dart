// // ignore_for_file: avoid_print, non_constant_identifier_names

// import 'package:apptvshow/ads/ads_Model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';

// class UnityAdsExampleApp extends StatelessWidget {
//   const UnityAdsExampleApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Unity Ads Example',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Unity Ads Example'),
//         ),
//         body: const SafeArea(
//           child: UnityAdsExample(),
//         ),
//       ),
//     );
//   }
// }

// class UnityAdsExample extends StatefulWidget {
//   const UnityAdsExample({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _UnityAdsExampleState createState() => _UnityAdsExampleState();
// }

// class _UnityAdsExampleState extends State<UnityAdsExample> {
//   bool _showBanner = false;
//   Map<String, bool> placements = {
//     "vadio": false,
//     // AdManager.rewardedVideoAdPlacementId: false,
//   };

//   @override
//   void initState() {
//     super.initState();
//     UnityAds.init(
//       gameId: "5512708",
//       testMode: true,
//       onComplete: () {
//         print('Initialization Complete');
//         _loadAds();
//       },
//       onFailed: (error, message) =>
//           print('Initialization Failed: $error $message'),
//     );
//   }

//   Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _showBanner = !_showBanner;
//                   });
//                 },
//                 child: Text(_showBanner ? 'Hide Banner' : 'Show Banner'),
//               ),
//               // ElevatedButton(
//               //   onPressed:
//               //       placements[AdManager.rewardedVideoAdPlacementId] == true
//               //           ? () => _showAd(AdManager.rewardedVideoAdPlacementId)
//               //           : null,
//               //   child: const Text('Show Rewarded Video'),
//               // ),
//               ElevatedButton(
//                 onPressed:
//                     // placements[AdManager.interstitialVideoAdPlacementId] == true
//                     () => _showAd('vadio'),
//                 // : null,
//                 child: const Text('Show Interstitial Video'),
//               ),
//             ],
//           ),
//           if (_showBanner)
//             UnityBannerAd(
//               placementId: "Banner_Android",
//               onLoad: (placementId) => print('Banner loaded: $placementId'),
//               onClick: (placementId) => print('Banner clicked: $placementId'),
//               onShown: (placementId) => print('Banner shown: $placementId'),
//               onFailed: (placementId, error, message) =>
//                   print('Banner Ad $placementId failed: $error $message'),
//             ),
//         ],
//       ),
//     );
//   }

//   void _loadAds() {
//     for (var placementId in placements.keys) {
//       _loadAd(placementId);
//     }
//   }

//   void _loadAd(String placementId) {
//     UnityAds.load(
//       placementId: placementId,
//       onComplete: (placementId) {
//         print('Load Complete $placementId');
//         setState(() {
//           placements[placementId] = true;
//         });
//       },
//       onFailed: (placementId, error, message) =>
//           print('Load Failed $placementId: $error $message'),
//     );
//   }

//   void _showAd(String placementId) {
//     setState(() {
//       placements[placementId] = false;
//     });
//     UnityAds.showVideoAd(
//       placementId: placementId,
//       onComplete: (placementId) {
//         print('Video Ad $placementId completed');
//         _loadAd(placementId);
//       },
//       onFailed: (placementId, error, message) {
//         print('Video Ad $placementId failed: $error $message');
//         _loadAd(placementId);
//       },
//       onStart: (placementId) => print('Video Ad $placementId started'),
//       onClick: (placementId) => print('Video Ad $placementId click'),
//       onSkipped: (placementId) {
//         print('Video Ad $placementId skipped');
//         _loadAd(placementId);
//       },
//     );
//   }
// }

// class AdManager {
//   Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
//   String get gameId {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       return "${ads_mOdel.unity_game_id}";
//     }

//     return '';
//   }

//   String? get bannerAdPlacementId {
//     return "${ads_mOdel.unity_banner_placement_id}";
//   }

//   String get interstitialVideoAdPlacementId {
//     return '${ads_mOdel.unity_interstitial_placement_id}';
//   }

//   // static String get rewardedVideoAdPlacementId {
//   //   return 'your_rewarded_video_ad_placement_id';
//   // }
// }

// ignore_for_file: camel_case_types, avoid_print, file_names, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:apptvshow/constant.dart';
// import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class Ads_MOdel extends GetxController {
  late AdmobInterstitial interstitialAd;
  List get adsApp => _adsApp;
  final List _adsApp = [];
  // Ads_MOdel() {
  //   getAds();
  // }
  String? get topic => _topic;

  String? _topic;
  ///// unity ads
  String? get unity_game_id => _unity_game_id;
  String? _unity_game_id;
  String? get unity_banner_placement_id => _unity_banner_placement_id;
  String? _unity_banner_placement_id;
  String? get unity_interstitial_placement_id =>
      _unity_interstitial_placement_id;
  String? _unity_interstitial_placement_id;
  String? get test_mode => _test_mode;
  String? _test_mode;

  Future getAds() async {
    var url = Uri.parse('$UrlApp$adsapp33$apikey');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map ads1 = {};
      ads1.addAll(data["ads"]);
      _adsApp.add(ads1);
      // for (int i = 0; i < ads1.length; i++) {
      //   _adsApp.add(AdsUnit1(
      //     adStatus: ads1[i][("ad_status")],
      //     admobBannerUnitId: ads1[i]["admob_banner_unit_id"],
      //     admobInterstitialUnitId: ads1[i]["admob_interstitial_unit_id"],
      //   ));
      // }
      _topic = _adsApp[0]['fcm_notification_topic'];
      // print(topic);
      // print("============++++++++++++++++++++");
      if (_adsApp[0]['ad_status'] == "on") {
        if (_adsApp[0]['ad_type'] == "admob") {
          interstitialAd = AdmobInterstitial(
            adUnitId: "${_adsApp[0]['admob_interstitial_unit_id']}",
            listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
              if (event == AdmobAdEvent.closed) interstitialAd.load();
              // handleEvent(event, args, 'Interstitial');
              interstitialAd.load();
            },
          );
        } else {
          print("=============AHMED==================");
          _unity_game_id = "${_adsApp[0]['unity_game_id']}";
          _unity_banner_placement_id =
              "${_adsApp[0]['unity_banner_placement_id']}";
          _unity_interstitial_placement_id =
              "${_adsApp[0]['unity_interstitial_placement_id']}";
          _test_mode = "${_adsApp[0]['test_mode']}";
          print(unity_banner_placement_id);
          print(unity_interstitial_placement_id);
          print(unity_game_id);
          print(test_mode == "1");
        }
      } else {}
      _adsApp[0]['ad_status'] == "on" ? interstitialAd.load() : "";
    } else {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }

    update();
  }

  // getinterstitialAd() {
  //   if (_adsApp[0]['ad_status'] == "on") {
  //     interstitialAd = AdmobInterstitial(
  //       adUnitId: "${_adsApp[0]['admob_interstitial_unit_id']}",
  //       listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
  //         if (event == AdmobAdEvent.closed) interstitialAd.load();
  //         // handleEvent(event, args, 'Interstitial');
  //         interstitialAd.load();
  //       },
  //     );
  //   } else {}
  //   _adsApp[0]['ad_status'] == "on" ? interstitialAd.load() : "";
  // }
  static String aaa = '';
  // static String get interstitialVideoAdPlacementId =>
  //     _unity_interstitial_placement_id;
  Map<String, bool> placements = {
    aaa: false,
    // AdManager.rewardedVideoAdPlacementId: false,
  };

//  static String get interstitialVideoAdPlacementId {
//     return '$unity_interstitial_placement_id';
//   }
  void _loadAds() {
    for (var placementId in placements.keys) {
      _loadAd(placementId);
    }
  }

  void _loadAd(String placementId) {
    UnityAds.load(
      placementId: placementId,
      onComplete: (placementId) {
        print('Load Complete $placementId');

        placements[placementId] = true;
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  void showAd(String placementId) {
    placements[placementId] = false;

    UnityAds.showVideoAd(
      placementId: placementId,
      onComplete: (placementId) {
        print('Video Ad $placementId completed');
        _loadAd(placementId);
      },
      onFailed: (placementId, error, message) {
        print('Video Ad $placementId failed: $error $message');
        _loadAd(placementId);
      },
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) {
        print('Video Ad $placementId skipped');
        _loadAd(placementId);
      },
    );
  }
}

// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors_in_immutables, file_names, avoid_print, unrelated_type_equality_checks, duplicate_ignore

import 'package:admob_flutter/admob_flutter.dart';
import 'package:apptvshow/ads/ads_Model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

String? topic;

class AdsFuture extends StatefulWidget {
  AdsFuture({
    Key? key,
  }) : super(key: key);

  @override
  State<AdsFuture> createState() => _AdsFutureState();
}

class _AdsFutureState extends State<AdsFuture> {
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    // ads_mOdel.getAds();
    UnityAds.init(
      gameId: "${ads_mOdel.unity_game_id}",
      testMode: ads_mOdel.test_mode == "1" ? true : false,
      onComplete: () {
        print('Initialization Complete');
      },
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
    // print(
    //   ads_mOdel.test_mode == "1" ? true : false,
    // );

    super.initState();
    print(ads_mOdel.unity_game_id);
    print(ads_mOdel.test_mode);
    print("=================================");
  }

  // void _loadAd(String placementId) {
  //   UnityAds.load(
  //     placementId: placementId,
  //     onComplete: (placementId) {
  //       print('Load Complete $placementId');
  //       setState(() {
  //         // placements[placementId] = true;
  //       });
  //     },
  //     onFailed: (placementId, error, message) =>
  //         print('Load Failed $placementId: $error $message'),
  //   );
  // }

  Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ads_mOdel.getAds(),
      builder: (context, snapshot) {
        return Container(
          // ignore: unrelated_type_equality_checks

          height: ads_mOdel.adsApp[0]["ad_status"] == "on" ? 55 : 0,
          width: double.infinity,
          // color: Colors.red,
          child: ads_mOdel.adsApp[0]["ad_status"] == "on"
              ? ads_mOdel.adsApp[0]["ad_type"] == "admob"
                  ? AdmobBanner(
                      adUnitId:
                          "${ads_mOdel.adsApp[0]["admob_banner_unit_id"]}",
                      adSize: AdmobBannerSize.BANNER,
                    )
                  : UnityBannerAd(
                      placementId: "${ads_mOdel.unity_banner_placement_id}",
                      onLoad: (placementId) =>
                          print('Banner loaded: $placementId'),
                      onClick: (placementId) =>
                          print('Banner clicked: $placementId'),
                      onShown: (placementId) =>
                          print('Banner shown: $placementId'),
                      onFailed: (placementId, error, message) => print(
                          'Banner Ad $placementId failed: $error $message'),
                    )
              : const Text(""),
        );
      },
    );
  }
}

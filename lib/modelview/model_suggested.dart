// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/constant.dart';
import 'package:apptvshow/dlna/dlna2.dart';
import 'package:apptvshow/model/TvShowModel.dart';
import 'package:device_apps/device_apps.dart';
import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ModelSuggested extends GetxController {
  List<Suggested> get movieshome => _movieshome;
  final List<Suggested> _movieshome = [];
  int a = 140;
  Future suggestedApp(String web, int id) async {
    var url = Uri.parse('$UrlApp$web$id');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List movis = [];
      movis.addAll(data["suggested"]);

      for (int i = 0; i < movis.length; i++) {
        _movieshome.add(
          Suggested(
              categoryId: movis[i]["category_id"],
              categoryName: movis[i]["category_name"],
              channelDescription: movis[i]["channel_description"],
              channelId: movis[i]["channel_id"],
              channelName: movis[i]["channel_name"],
              channelImage: movis[i]["channel_image"],
              channelType: movis[i]["channel_type"],
              channelUrl: movis[i]["channel_url"],
              userAgent: movis[i]["user_agent"],
              videoId: movis[i]["video_id"]),
        );
      }

      // print(movis);
    } else {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }

    update();
  }

  void checkVLCInstallation(String url, String name) async {
    bool isVLCInstalled = await DeviceApps.isAppInstalled("org.videolan.vlc");

    if (isVLCInstalled) {
      ExternalVideoPlayerLauncher.launchVlcPlayer(
          url, MIME.applicationXMpegURL, {
        "title": name,
      });
    } else {
      Get.snackbar(
        "Error",
        "VLC is not installed on the device!",
        backgroundColor: Colors.black,
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    }
    update();
  }

  void checkVLCInstallation2(String url, String name) async {
    bool isMXInstalled =
        await DeviceApps.isAppInstalled("com.mxtech.videoplayer.ad");
    if (isMXInstalled) {
      print('MX is installed on the device!');
      ExternalVideoPlayerLauncher.launchMxPlayer(url, MIME.applicationMp4, {
        "title": name,
      });
    } else {
      print('VLC is not installed on the device!');
      Get.snackbar(
        "Error",
        "MX Player is not installed on the device!",
        backgroundColor: Colors.black,
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    }
    update();
  }

  void share(String url, String name) {
    Get.defaultDialog(
      backgroundColor: ColorApp.bgHome,
      title: "Choose your favorite player to watch",
      titleStyle: const TextStyle(color: Colors.white),
      radius: 25,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Get.to(DlnaDeviceList2(
                videoId: url,
              ));
            },
            child: Image.asset(
              "images/dlna.png",
              color: Colors.white,
              height: 60,
              width: 60,
            ),
          ),
          InkWell(
            onTap: () {
              checkVLCInstallation(url, name);
            },
            child: Image.asset(
              "images/vlc.png",
              height: 60,
              width: 60,
            ),
          ),
          InkWell(
            onTap: () {
              checkVLCInstallation2(url, name);
            },
            child: Image.asset(
              "images/mx.png",
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
    update();
  }
}

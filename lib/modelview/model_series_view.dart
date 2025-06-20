// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:apptvshow/constant.dart';
import 'package:apptvshow/model/modelSeries.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SeriesApp extends GetxController {
  List<Series1> get catindex3 => _catindex3;
  final List<Series1> _catindex3 = [];

  Future getcatindextv(int cid) async {
    var url = Uri.parse('$UrlApp$categorypost3$cid&$conut$apikey');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List ch = [];
      ch.addAll(data["posts"]);
      // movis.shuffle();

      for (int i = 0; i < ch.length; i++) {
        _catindex3.add(
          Series1(
              categoryId: ch[i]["category_id"],
              categoryName: ch[i]["category_name"],
              channelDescription: ch[i]["channel_description"],
              channelId: ch[i]["channel_id"],
              channelName: ch[i]["channel_name"],
              channelImage: ch[i]["channel_image"],
              channelType: ch[i]["channel_type"],
              channelUrl: ch[i]["channel_url"],
              userAgent: ch[i]["user_agent"],
              videoId: ch[i]["video_id"]),
        );
      }
    } else {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }
    update();
    return _catindex3;
  }
}

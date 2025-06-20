// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:apptvshow/constant.dart';

import 'package:apptvshow/model/model_Tv_CT.dart';
import 'package:apptvshow/model/modelch.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Series extends GetxController {
  // TVCat() {
  //   getcat2();
  //   getcat();
  // }
  List<CategoriesTV> get lastch => _lastch;
  final List<CategoriesTV> _lastch = [];
  List<CategoriesTV> get lastch2 => _lastch2;
  final List<CategoriesTV> _lastch2 = [];

  List<Channel> get catindex => _catindex;
  final List<Channel> _catindex = [];
  bool get loding => _loding;
  bool _loding = false;

  Future getcat() async {
    _loding = false;
    var url = Uri.parse('$UrlApp$categoryseries$apikey');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List ch = [];
      ch.addAll(data["categories"]);
      // movis.shuffle();

      for (int i = 0; i < ch.length; i++) {
        _lastch.add(CategoriesTV(
          categoryName: ch[i]["category_name"],
          categoryImage: ch[i]["category_image"],
          cid: ch[i]["cid"],
        ));
      }
      _loding = true;

      // print(lastch.length);

      print(lastch.length);
    } else {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }

    update();
  }

  Future getcat2() async {
    var url = Uri.parse('$UrlApp$categorymovies$apikey');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List ch = [];
      ch.addAll(data["categories"]);
      // movis.shuffle();

      for (int i = 0; i < ch.length; i++) {
        _lastch2.add(CategoriesTV(
          categoryName: ch[i]["category_name"],
          categoryImage: ch[i]["category_image"],
          cid: ch[i]["cid"],
        ));
      }

      // print(lastch.length);

      print(lastch2.length);
    } else {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }

    update();
  }

  // List ch = [];
  // int? cid1;
  Future getcatindextv(int cid) async {
    var url = Uri.parse('$UrlApp$categorypost2$cid&$conut$apikey');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List ch = [];
      ch.addAll(data["posts"]);
      // movis.shuffle();

      for (int i = 0; i < ch.length; i++) {
        _catindex.add(
          Channel(
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

      // print(lastch.length);

      // print("$UrlApp$categorypost$cid&$conut$apikey");
      print(catindex.length);
    } else {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }

    update();
    return _catindex;
  }
}

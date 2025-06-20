// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:apptvshow/constant.dart';

import 'package:apptvshow/model/model_Tv_CT.dart';
import 'package:apptvshow/model/modelch.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class TVCat extends GetxController {

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('ws://34.72.67.6:8089'),
    Uri.parse('ws://34.28.167.72:8089'),
  );

  late List<String> urlList;
  late String name;
  // TVCat() {
  //   getcat2();
  //   getcat();
  // }
  List<CategoriesTV> get lastch => _lastch;
  final List<CategoriesTV> _lastch = [];
  List<CategoriesTV> get lastch2 => _lastch2;
  final List<CategoriesTV> _lastch2 = [];
  List<CategoriesTV> get lastch3 => _lastch3;
  final List<CategoriesTV> _lastch3 = [];

  List<Channel> get catindex => _catindex;
  final List<Channel> _catindex = [];
  bool get loding => _loding;
  bool _loding = false;

  Future getcat() async {
    _loding = false;

    var url = Uri.parse('$UrlApp$categorytvshow$apikey');

    var response = await http.get(url);
    print("URL-re kapott valasz");
    print(response.body);

    _channel = WebSocketChannel.connect(
      //Uri.parse('ws://34.72.67.6:8089'),
      Uri.parse('ws://34.28.167.72:8089'),
    );
    //kerdes = "catimages|mindegymivanitt";
    _channel.sink.add("catimages|mindegymivanitt");
    print("kerdesem ");
    //print(kerdes);
    _channel.stream.listen(
          (message) {
        // A lista kinyerése a message stringből
        String listPart = message.substring(message.indexOf("["));
        // A listát egy Dart List-ként parse-oljuk
        urlList = List<String>.from(jsonDecode(listPart.replaceAll("'", '"')));
        // Az eredmény megjelenítése
        print('WEBSOCKET RESULT Received message: $message');
        print(urlList);
        print(urlList[1]);
        print(urlList.length);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List ch = [];
          ch.addAll(data["categories"]);
          // movis.shuffle();

          for (int i = 0; i < urlList.length; i++) {
            print(ch[i]["cid"]);
            name = urlList[i].split("/")[4].split(".")[0];
            _lastch.add(CategoriesTV(
              categoryName: urlList[i].split("/")[4].split(".")[0],
              categoryImage: urlList[i],//ch[i]["category_image"],
              cid: 49,//ch[i]["cid"],
            ));
          }
          _loding = true;

          // print(lastch.length);

          print(lastch.length);
        } else {
          print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        }
        _channel.sink.close();
      },
      onDone: () {
        print('WebSocket channel closed');
      },
      onError: (error) {
        print('WebSocket server not found');
      },
    );

    update();
  }



  Future getcat2() async {
    var url = Uri.parse('$UrlApp$categorymovies$apikey');

    var response = await http.get(url);

    _channel = WebSocketChannel.connect(
      //Uri.parse('ws://34.72.67.6:8089'),
      Uri.parse('ws://34.28.167.72:8089'),
    );
    //kerdes = "catimages|mindegymivanitt";
    _channel.sink.add("catimages|mindegymivanitt");
    print("kerdesem ");
    //print(kerdes);
    _channel.stream.listen(
          (message) {
        // A lista kinyerése a message stringből
        String listPart = message.substring(message.indexOf("["));
        // A listát egy Dart List-ként parse-oljuk
        List<String> urlList = List<String>.from(jsonDecode(listPart.replaceAll("'", '"')));
        // Az eredmény megjelenítése
        print('WEBSOCKET RESULT Received message: $message');
        print(urlList);
        print(urlList[1]);
        print(urlList.length);
        _channel.sink.close();
      },
      onDone: () {
        print('WebSocket channel closed');
      },
      onError: (error) {
        print('WebSocket server not found');
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List ch = [];
      ch.addAll(data["categories"]);
      // movis.shuffle();

      for (int i = 0; i < ch.length; i++) {
        _lastch2.add(CategoriesTV(
          categoryName: ch[i]["category_name"],
          categoryImage: "https://storage.googleapis.com/lomeeibucket/matek.jpeg",//ch[i]["category_image"],
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


  Future getcat3() async {
    var url = Uri.parse('$UrlApp$categoryseries$apikey');

    var response = await http.get(url);

    _channel = WebSocketChannel.connect(
      //Uri.parse('ws://34.72.67.6:8089'),
      Uri.parse('ws://34.28.167.72:8089'),
    );
    //kerdes = "catimages|mindegymivanitt";
    _channel.sink.add("catimages|mindegymivanitt");
    print("kerdesem ");
    _channel.stream.listen(
          (message) {
        // A lista kinyerése a message stringből
        String listPart = message.substring(message.indexOf("["));
        // A listát egy Dart List-ként parse-oljuk
        urlList = List<String>.from(jsonDecode(listPart.replaceAll("'", '"')));
        // Az eredmény megjelenítése
        print('WEBSOCKET RESULT Received message: $message');
        print(urlList);
        print(urlList[1]);
        print(urlList.length);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List ch = [];
          ch.addAll(data["categories"]);
          // movis.shuffle();

          for (int i = 0; i < urlList.length; i++) {
            print(ch[i]["cid"]);
            name = urlList[i].split("/")[4].split(".")[0];
            _lastch3.add(CategoriesTV(
              categoryName: urlList[i].split("/")[4].split(".")[0],
              categoryImage: urlList[i],//ch[i]["category_image"],
              cid: 49,//ch[i]["cid"],
            ));
          }
          _loding = true;

          // print(lastch.length);

          print(lastch.length);
        } else {
          print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        }
        _channel.sink.close();
      },
      onDone: () {
        print('WebSocket channel closed');
      },
      onError: (error) {
        print('WebSocket server not found');
      },
    );

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

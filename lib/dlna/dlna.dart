// ignore_for_file: file_names, deprecated_member_use, prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:async';

import 'package:apptvshow/color/colorapp.dart';
// import 'package:apptvshow/videoplayer/vaido2.dart';
import 'package:apptvshow/videoplayer/vaido33.dart';
// import 'package:apptvshow/videoplayer/video_player.dart';
import 'package:flutter/material.dart';
import 'package:dlna_dart/dlna.dart';
import 'package:flutter/services.dart';

import 'toast.dart';

import 'DlnaDialog.dart';

Map<String, DLNADevice> cacheDeviceList = {};

class DlnaDeviceList extends StatefulWidget {
  final String? videoId;
  // ignore: prefer_typing_uninitialized_variables
  final index;
  const DlnaDeviceList(
      {Key? key, this.videoId, this.index, this.user, required bool booll})
      : super(key: key);
  final user;
  @override
  State<StatefulWidget> createState() {
    return _DlnaDeviceListState();
  }
}

class _DlnaDeviceListState extends State<DlnaDeviceList> {
  late DLNAManager searcher;
  late final DeviceManager m;
  Map<String, DLNADevice> deviceList = {};
  _DlnaDeviceListState();

  @override
  initState() {
    super.initState();
    searcher = DLNAManager();
    init();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  init() async {
    m = await searcher.start();
    m.devices.stream.listen((dlist) {
      dlist.forEach((key, value) {
        cacheDeviceList[key] = value;
      });
      setState(() {
        deviceList = cacheDeviceList;
      });
    });
    await _pullToRefresh();
  }

  @override
  void dispose() {
    searcher.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return VideoApp222(
            link: widget.videoId,
            userAgent: widget.user,
          );
        }));
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // appBar: AppBar(
            //   title: const Text('Searching for devices'),
            //   centerTitle: true,
            //   backgroundColor: const Color.fromARGB(255, 31, 8, 70),
            // ),
            backgroundColor: ColorApp.bgHome,
            body: RefreshIndicator(onRefresh: _pullToRefresh, child: _body())),
      ),
    );
  }

  Future _pullToRefresh() async {
    m.deviceList.forEach((key, value) {
      cacheDeviceList[key] = value;
    });
    setState(() {
      deviceList = cacheDeviceList;
    });
  }

  Widget _body() {
    if (deviceList.isEmpty) {
      return const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 15,
          ),
          Text(
            "Searching for devices",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      )
          // Text(
          //   "aaaaaaaaaaaaaaaaaaaaaaaaa",
          //   style: TextStyle(color: Colors.white, fontSize: 25),
          // ),
          );
    }
    final List<Widget> dlist = [];
    deviceList.forEach((uri, devi) {
      dlist.add(buildItem(uri, devi));
    });

    return ListView(
      children: dlist,
    );
  }

  Widget buildItem(String uri, DLNADevice device) {
    final title = device.info.friendlyName;
    final subtitle = '$uri\r\n${device.info.deviceType}';
    final s = subtitle.toLowerCase();
    var icon = Icons.cast;
    final support = s.contains("mediarenderer") ||
        s.contains("avtransport") ||
        s.contains('mediaserver');
    if (!support) {
      icon = Icons.router;
    }
    final card = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              bottom: 30,
            ),
            child: CircleAvatar(
              child: Icon(icon),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 100, 100, 135),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    children: <Widget>[
                      // Expanded(
                      //   child: Text(
                      //     subtitle,
                      //     softWrap: false,
                      //     maxLines: 2,
                      //     overflow: TextOverflow.fade,
                      //     style: const TextStyle(
                      //       fontSize: 12,
                      //       color: Color.fromARGB(255, 100, 100, 135),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        child: card,
        onTap: () {
          if (!support) {
            const msg =
                "This device does not support digital screen recording.";
            Toast.toast(context, msg);
            return;
          }
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    DlnaDialog(
                      device,
                      videoId: widget.videoId,
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';

import 'package:apptvshow/dlna/toast.dart';
import 'package:flutter/material.dart';
import 'package:dlna_dart/dlna.dart';
import 'package:dlna_dart/xmlParser.dart';
import 'package:flutter/services.dart';

import 'DlnaStreamItems.dart';

class DlnaDialog extends StatefulWidget {
  final DLNADevice dev;
  final String? videoId;
  const DlnaDialog(this.dev, {Key? key, this.videoId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DlnaDialogState();
  }
}

class _DlnaDialogState extends State<DlnaDialog> {
  PositionParser? position;
  TextEditingController videoUrl = TextEditingController();
  Timer timer = Timer(const Duration(seconds: 1), () {});

  @override
  void initState() {
    super.initState();
    callback(_) async {
      final text = await widget.dev.position();
      final p = PositionParser(text);
      setState(() {
        position = p;
      });
    }

    timer = Timer.periodic(const Duration(seconds: 5), callback);
    callback(null);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialog = ListView(
      children: [
        Container(
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: Text(
            widget.dev.info.friendlyName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: Text(
            widget.dev.info.URLBase,
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ),
        SizedBox(
          height: 160,
          child: buildCurrUri(),
        ),
        buildActions(),
      ],
    );

    return SizedBox(
      height: 430,
      width: MediaQuery.of(context).size.width - 100,
      child: dialog,
    );
  }

  Widget buildCurrUri() {
    if (position == null || position!.TrackURI.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: const Text("No video info yet"),
      );
    }
    final List<Widget> slist = [];
    slist.add(const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Currently playing:",
        style: TextStyle(color: Colors.green),
      ),
    ));
    var currUrl = position!.TrackURI;
    if (currUrl.length > 100) {
      currUrl = '${currUrl.substring(0, 100)}...';
    }
    slist.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              child: const Text(
                  // currUrl,
                  // style: const TextStyle(fontSize: 12, color: Colors.orange),
                  // textAlign: TextAlign.left,
                  ''),
              onTap: () {
                ClipboardData data = ClipboardData(text: position!.TrackURI);
                Clipboard.setData(data);
                Toast.toast(context, "نسخ");
              },
            ))));
    if (position!.AbsTime.isNotEmpty) {
      slist.add(Align(
        alignment: Alignment.topLeft,
        child: Text("${position!.AbsTime} / ${position!.TrackDuration}"),
      ));
    }
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 1,
          color: Colors.white70,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: slist,
            ),
          ),
        ));
  }

  Widget buildActions() {
    const style = TextStyle(fontSize: 12);
    // final ok = ElevatedButton(
    //   child: const Text("تؤكد"),
    //   onPressed: () async {
    //     final v = videoUrl.value.text;
    //     if (v.isEmpty) {
    //       Toast.toast(context, "الرجاء إدخال عنوان http");
    //       return;
    //     }
    //     try {
    //       await widget.dev.setUrl(v);
    //       await widget.dev.play();
    //     } catch (e) {
    //       Toast.toast(context, "$e");
    //     }
    //     Navigator.pop(context);
    //     Timer(const Duration(seconds: 2), () async {
    //       final text = await widget.dev.position();
    //       position = PositionParser(text);
    //     });
    //   },
    // );
    final content = DlnaStreamItems(widget.dev, widget.videoId!);
    //  content = widget.videoId != null && widget.videoId!.isNotEmpty
    // ? DlnaStreamItems(widget.dev, widget.videoId!) //  مشغل خارجى
    // : Column(
    //     children: [
    //       TextField(
    //           controller: videoUrl,
    //           decoration: const InputDecoration(
    //             icon: Icon(Icons.link),
    //             labelText: "عنوان HTTP",
    //           )),
    //       ButtonBar(
    //         alignment: MainAxisAlignment.center,
    //         children: [ok],
    //       ),
    //     ],
    //   );
    final push = ElevatedButton(
      child: const Text("Play"),
      onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) => SingleChildScrollView(
                child: Container(
                    height: 100,
                    padding: EdgeInsets.fromLTRB(
                        10, 10, 10, MediaQuery.of(context).viewInsets.top),
                    child: content),
              )),
    );
    final play = SizedBox(
        width: 110,
        height: 40,
        child: ElevatedButton(
          onPressed: () async {
            try {
              await widget.dev.play();
            } catch (e) {
              Toast.toast(context, "$e");
            }
          },
          child: const Text(
            "Playagain",
            style: style,
          ),
        ));
    final pause = SizedBox(
        width: 85,
        height: 40,
        child: ElevatedButton(
            onPressed: () async {
              try {
                await widget.dev.pause();
              } catch (e) {
                Toast.toast(context, "$e");
              }
            },
            child: const Text(
              "pause",
              style: style,
            )));
    final stop = SizedBox(
        width: 85,
        height: 40,
        child: ElevatedButton(
            onPressed: () async {
              try {
                await widget.dev.stop();
              } catch (e) {
                Toast.toast(context, "$e");
              }
            },
            child: const Text("Stop", style: style)));
    // final prev10 = SizedBox(
    //     width: 90,
    //     height: 30,
    //     child: ElevatedButton(
    //         onPressed: () async {
    //           try {
    //             final curr = await widget.dev.position();
    //             final p = PositionParser(curr);
    //             setState(() {
    //               position = p;
    //             });
    //             widget.dev.seekByCurrent(curr, -10);
    //           } catch (e) {
    //             Toast.toast(context, "$e");
    //           }
    //         },
    //         child: const Text("ترجيع 10 ثوان", style: style)));
    // final next10 = SizedBox(
    //     width: 90,
    //     height: 30,
    //     child: ElevatedButton(
    //         onPressed: () async {
    //           try {
    //             final curr = await widget.dev.position();
    //             final p = PositionParser(curr);
    //             setState(() {
    //               position = p;
    //             });
    //             widget.dev.seekByCurrent(curr, 10);
    //           } catch (e) {
    //             Toast.toast(context, "$e");
    //           }
    //         },
    //         child: const Text("تقديم سريع بمقدار 10 ثوانٍ", style: style)));

    // final prev30 = SizedBox(
    //     width: 90,
    //     height: 30,
    //     child: ElevatedButton(
    //         onPressed: () async {
    //           try {
    //             final curr = await widget.dev.position();
    //             final p = PositionParser(curr);
    //             setState(() {
    //               position = p;
    //             });
    //             await widget.dev.seekByCurrent(curr, -30);
    //           } catch (e) {
    //             Toast.toast(context, "$e");
    //           }
    //         },
    //         child: const Text("ترجيع 30 ثانية", style: style)));
    // final next30 = SizedBox(
    //     width: 90,
    //     height: 30,
    //     child: ElevatedButton(
    //         onPressed: () async {
    //           try {
    //             final curr = await widget.dev.position();
    //             final p = PositionParser(curr);
    //             setState(() {
    //               position = p;
    //             });
    //             await widget.dev.seekByCurrent(curr, 30);
    //           } catch (e) {
    //             Toast.toast(context, "$e");
    //           }
    //         },
    //         child: const Text("تقديم سريع 30 ثانية", style: style)));

    return Column(
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            push,
          ],
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            play,
            pause,
            stop,
          ],
        ),
        // ButtonBar(
        //   alignment: MainAxisAlignment.center,
        //   children: [next10, prev10],
        // ),
        // ButtonBar(
        //   alignment: MainAxisAlignment.center,
        //   children: [next30, prev30],
        // ),
      ],
    );
  }
}

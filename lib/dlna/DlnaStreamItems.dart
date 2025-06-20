// ignore_for_file: file_names, use_build_context_synchronously

import 'package:apptvshow/dlna/toast.dart';
import 'package:flutter/material.dart';

import 'package:dlna_dart/dlna.dart';

class DlnaStreamItems extends StatelessWidget {
  final DLNADevice dev;
  final String videoId;
  const DlnaStreamItems(this.dev, this.videoId, {Key? key}) : super(key: key);

  String getUrl(int type) {
    // ignore: unnecessary_string_interpolations
    final base = '$videoId';
    if (type == 1) {
      return "$base?prefer=18,59,22,37";
    } else if (type == 2) {
      return "$base?prefer=37,22,59,18";
    } else if (type == 3) {
      return "$base?prefer=251,250,140,599";
    }
    return "$base?prefer=247,244,243,136,135";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25)),
                    width: 150,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Start Now Player",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          onTap: () async {
            Navigator.of(context).pop();
            try {
              await dev.setUrl(videoId);
              await dev.play();
            } catch (e) {
              Toast.toast(context, "$e");
            }
            // Navigator.of(context).pop();
          },
        ),
        // InkWell(
        //   child: Row(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        //         child: const Text("عالية الدقة"),
        //       )
        //     ],
        //   ),
        //   onTap: () async {
        //     try {
        //       await dev.setUrl(videoId);
        //       await dev.play();
        //     } catch (e) {
        //       Toast.toast(context, "$e");
        //     }
        //   },
        // ),
        // InkWell(
        //   child: Row(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        //         child: const Text("وضع الصوت فقط"),
        //       )
        //     ],
        //   ),
        //   onTap: () async {
        //     try {
        //       await dev.setUrl(videoId);
        //       await dev.play();
        //     } catch (e) {
        //       Toast.toast(context, "$e");
        //     }
        //   },
        // ),
        // InkWell(
        //   child: Row(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        //         child: const Text("وضع الفيديو فقط"),
        //       )
        //     ],
        //   ),
        //   onTap: () async {
        //     try {
        //       await dev.setUrl(videoId);
        //       await dev.play();
        //     } catch (e) {
        //       Toast.toast(context, "$e");
        //     }
        //   },
        // ),
      ],
    );
  }
}

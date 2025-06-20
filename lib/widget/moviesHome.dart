// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:apptvshow/modelview/viewHome.dart';
import 'package:apptvshow/screen/tvShow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class MoviesHome extends StatefulWidget {
  @override
  State<MoviesHome> createState() => _MoviesHomeState();
}

class _MoviesHomeState extends State<MoviesHome> {
  ViewHome viewHome = Get.put(ViewHome());
  @override
  void initState() {
    // viewHome.moviesHomeapp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewHome>(
      init: ViewHome(),
      builder: (count) {
        return count.movieshome.isEmpty
            ? const Text("Loding...")
            : ListView.builder(
            itemCount: count.movieshome.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final chid = count.movieshome[i].channelId;
              final ch_name = count.movieshome[i].channelName;
              final ch_image = "$UrlApp$upload"
                  "${count.movieshome[i].channelImage}";
              final chUrl = count.movieshome[i].channelUrl;
              final ch_desc = count.movieshome[i].channelDescription;
              final ch_type = count.movieshome[i].channelType;
              final ch_videoid = count.movieshome[i].videoId;
              final ctag_name = count.movieshome[i].categoryName;
              final ch_useragent = count.movieshome[i].userAgent;
              const web = detail;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(TvShow(
                        chid: chid,
                        ch_desc: ch_desc,
                        ch_image: ch_image,
                        ch_name: ch_name,
                        ch_type: ch_type,
                        chUrl: chUrl,
                        ch_videoid: ch_videoid,
                        ch_useragent: ch_useragent,
                        ctag_name: ctag_name,
                        web: web));
                  },
                  child: Container(
                    // color: Colors.yellow,

                    width: 220,//110,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CachedNetworkImage(
                                imageUrl: count.movieshome.isEmpty
                                    ? imagesloding
                                    : //"$UrlApp$upload"
                                "${count.movieshome[i].channelImage}",
                                height: 150,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                          // colorFilter:
                                          //     ColorFilter.mode(Colors.red, BlendMode.darken),
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) => Center(
                                  child: Image.asset("images/tv.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    color: Colors.red),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    count.movieshome.isEmpty
                                        ? "a"
                                        : "${count.movieshome[i].categoryName}",
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.yellowAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              count.movieshome.isEmpty
                                  ? "a"
                                  : "${count.movieshome[i].channelName}",
                              maxLines: 2,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

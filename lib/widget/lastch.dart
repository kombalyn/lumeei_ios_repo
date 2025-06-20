// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace

import 'package:apptvshow/constant.dart';
import 'package:apptvshow/modelview/viewHome.dart';
import 'package:apptvshow/screen/tvShow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LastCh extends StatelessWidget {
  ViewHome viewHome = Get.put(ViewHome());

  LastCh({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewHome>(
        init: ViewHome(),
        builder: (count) {
          return ListView.builder(
              itemCount: count.lastch.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                final chid = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].channelId;
                final ch_name = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].channelName;
                final ch_image = count.lastch.isEmpty
                    ? imagesloding
                    : "$UrlApp$upload" "${viewHome.lastch[i].channelImage}";
                final chUrl = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].channelUrl;
                final ch_desc = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].channelDescription;
                final ch_type = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].channelType;
                final ch_videoid = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].videoId;
                final ctag_name = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].categoryName;
                final ch_useragent = count.lastch.isEmpty
                    ? imagesloding
                    : count.lastch[i].userAgent;
                // ignore: prefer_const_declarations
                final web = detail2;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        TvShow(
                          chid: chid,
                          ch_desc: ch_desc,
                          ch_image: ch_image,
                          ch_name: ch_name,
                          ch_type: ch_type,
                          chUrl: chUrl,
                          ch_videoid: ch_videoid,
                          ch_useragent: ch_useragent,
                          ctag_name: ctag_name,
                          web: web,
                        ),
                      );
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
                                  imageUrl: count.lastch.isEmpty
                                      ? imagesloding
                                      : //"$UrlApp$upload"
                                          "${count.lastch[i].channelImage}",
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
                                      count.lastch.isEmpty
                                          ? ""
                                          : "${count.lastch[i].categoryName}",
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
                                viewHome.lastch.isEmpty
                                    ? ""
                                    : "${viewHome.lastch[i].channelName}",
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
        });
  }
}

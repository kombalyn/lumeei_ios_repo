// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/constant.dart';
import 'package:apptvshow/model/modelMovies.dart';
import 'package:apptvshow/screen/tvShow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSearch extends SearchDelegate {
  List<Posts> prolist = [];
  AppSearch({
    required this.prolist,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("Search MOvies");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filter = prolist.where((element) {
      return element.channelName!.contains(query);
    }).toList();
    return Container(
      color: ColorApp.bgHome,
      child: ListView.builder(
          itemCount: query == '' ? prolist.length : filter.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            final chid =
                query == '' ? prolist[i].channelId : filter[i].channelId;
            final ch_name =
                query == '' ? prolist[i].channelName : filter[i].channelName;
            final ch_image = query == ''
                ? "$UrlApp$upload" "${prolist[i].channelImage}"
                : "$UrlApp$upload" + filter[i].channelImage;
            final chUrl =
                query == '' ? prolist[i].channelUrl : filter[i].channelUrl;
            final ch_desc = query == ''
                ? prolist[i].channelDescription
                : filter[i].channelDescription;
            final ch_type =
                query == '' ? prolist[i].channelType : filter[i].channelType;
            final ch_videoid =
                query == '' ? prolist[i].videoId : filter[i].videoId;
            final ctag_name =
                query == '' ? prolist[i].categoryName : filter[i].categoryName;
            final ch_useragent =
                query == '' ? prolist[i].userAgent : filter[i].userAgent;
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: query == ''
                                ? "$UrlApp$upload"
                                    "${prolist[i].channelImage}"
                                : "$UrlApp$upload"
                                    "${filter[i].channelImage}",
                            height: 70,
                            width: 70,
                            imageBuilder: (context, imageProvider) => Container(
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
                        // Positioned(
                        //   right: 10,
                        //   top: 10,
                        //   child: Container(
                        //     decoration: const BoxDecoration(
                        //         borderRadius: BorderRadius.only(
                        //             topRight: Radius.circular(20),
                        //             bottomLeft: Radius.circular(20)),
                        //         color: Colors.red),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Text(
                        //         query == ''
                        //             ? "${prolist[i].categoryName}"
                        //             : filter.isEmpty
                        //                 ? "a"
                        //                 : "${filter[i].categoryName}",
                        //         style: const TextStyle(
                        //             fontSize: 10,
                        //             color: Colors.yellowAccent,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          query == ""
                              ? "${prolist[i].channelName}"
                              : filter.isEmpty
                                  ? "a"
                                  : "${filter[i].channelName}",
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
            );
          }),
    );
  }
}

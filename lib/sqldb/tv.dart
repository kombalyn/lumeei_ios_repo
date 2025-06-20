// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_declarations, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_adjacent_string_concatenation

import 'package:apptvshow/constant.dart';
import 'package:apptvshow/screen/tvShow.dart';
import 'package:apptvshow/sqldb/db.dart';
import 'package:apptvshow/sqldb/dbModelView.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TV extends StatefulWidget {
  const TV({super.key});

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  SqlDb sqlDb = SqlDb();
  DBModelView dbModelView = Get.put(DBModelView());
  // List s = [];
  // Future reddate() async {
  //   // List a = await sqlDb.reddata("SELECT * FROM notes");
  //   List a = await sqlDb.red("ahmed");

  //   s.addAll(a);
  //   print(s.length);
  //   print("+++++++++++++++++++++++++++");
  // }

  @override
  void initState() {
    // reddate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DBModelView>(
      init: DBModelView(),
      builder: (count) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            count.ch2.isEmpty
                ? Center(
                    child: Image.asset(
                      "images/Empty.png",
                      height: 100,
                      width: 100,
                    ),
                  )
                : Expanded(
                    child: Container(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5, //  المسافه بينهم
                                  mainAxisSpacing: 8, //  المسافه بينهم
                                  childAspectRatio: 1,
                                  mainAxisExtent: 200 //  المسافه بينهم
                                  ),
                          itemCount: count.ch2.length,
                          itemBuilder: (context, i) {
                            final chid = count.ch2[i]['channelId'];
                            final index1 = count.ch2[i];
                            final chUrl = count.ch2[i]['channelUrl'];
                            final ch_videoid = count.ch2[i]['videoId'];
                            final ch_type = count.ch2[i]['channelType'];

                            final ch_name = count.ch2[i]['channelName'];
                            final ch_image = "${count.ch2[i]['channelImage']}";

                            final ch_desc = count.ch2[i]['channelDescription'];

                            final ctag_name = count.ch2[i]['categoryName'];
                            final ch_useragent = count.ch2[i]['userAgent'];
                            final web = detail2;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (() {
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
                                  // Get.to(VaidoPlayer(
                                  //   chUrl: churl,
                                  // ));
                                }),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    // color: Colors.yellowAccent,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: count.ch2.isEmpty
                                                    ? imagesloding
                                                    : "${count.ch2[i]['channelImage']}",
                                                height: 150,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                      // colorFilter: const ColorFilter.mode(
                                                      //     Colors.deepPurple,
                                                      //     BlendMode.colorBurn),
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "images/tv.png"),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            child: Text(
                                              "${count.ch2[i]['channelId']}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: -0,
                                        top: 0,
                                        child: IconButton(
                                          onPressed: () async {
                                            // int res = await dbModelView.delete(
                                            //     "ahmed",
                                            // );
                                            int res = await dbModelView.delete2(
                                                "ch",
                                                "channelId =${chid}",
                                                index1);
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

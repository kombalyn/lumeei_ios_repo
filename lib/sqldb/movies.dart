// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_const_declarations, unused_local_variable

import 'package:apptvshow/constant.dart';
import 'package:apptvshow/screen/tvShow.dart';
import 'package:apptvshow/sqldb/db.dart';
import 'package:apptvshow/sqldb/dbModelView.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  SqlDb sqlDb = SqlDb();
  DBModelView dbModelView = Get.put(DBModelView());
  List s = [];
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
      builder: (count) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          count.dbmovies.isEmpty
              ? Center(
                  child: Image.asset(
                    "images/Empty.png",
                    height: 100,
                    width: 100,
                  ),
                )
              : Expanded(
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
                      itemCount: count.dbmovies.length,
                      itemBuilder: (context, i) {
                        final chid = count.dbmovies[i]['channelId'];
                        final index1 = count.dbmovies[i];
                        final chUrl = count.dbmovies[i]['channelUrl'];
                        final ch_videoid = count.dbmovies[i]['videoId'];
                        final ch_type = count.dbmovies[i]['channelType'];

                        final ch_name = count.dbmovies[i]['channelName'];
                        final ch_image = "${count.dbmovies[i]['channelImage']}";

                        final ch_desc = count.dbmovies[i]['channelDescription'];

                        final ctag_name = count.dbmovies[i]['categoryName'];
                        final ch_useragent = count.dbmovies[i]['userAgent'];
                        final web = detail;

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
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: count.dbmovies.isEmpty
                                                ? imagesloding
                                                : "${count.dbmovies[i]['channelImage']}",
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
                                                Image.asset("images/tv.png"),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        "${count.dbmovies[i]['channelName']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Cairo'),
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
                                        int res = await dbModelView.delete(
                                            "ahmed",
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
        ],
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, sized_box_for_whitespace, prefer_typing_uninitialized_variables, file_names

import 'package:apptvshow/ads/adsWidget.dart';
import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/constant.dart';
// import 'package:apptvshow/modelview/movies_ModelDeitels.dart';
import 'package:apptvshow/modelview/model_series_view.dart';
import 'package:apptvshow/screen/tvShow.dart';
// import 'package:apptvshow/screendetiels/detiels_CatogryMovies.dart';
// import 'package:apptvshow/widget/inmay.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesDetiles extends StatefulWidget {
  const SeriesDetiles({super.key, this.cid, this.name, this.images});
  final cid;
  final name;
  final images;

  @override
  State<SeriesDetiles> createState() => _SeriesDetilesState();
}

class _SeriesDetilesState extends State<SeriesDetiles> {
  SeriesApp seriesApp = Get.put(SeriesApp());

  @override
  Widget build(BuildContext context) {
    // MoviesModelCat moviesModelCat = Get.put(MoviesModelCat());
    return Scaffold(
      backgroundColor: ColorApp.bgHome,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 450,
                    // width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: UrlApp + upload2 + widget.images,
                      height: 300,
                      imageBuilder: (context, imageProvider) => Container(
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 30,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black.withOpacity(0.1),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AdsFuture(),
            Text(
              widget.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              // width: double.infinity,
              child: FutureBuilder(
                future: seriesApp.getcatindextv(widget.cid),
                builder: (context, snapshot) => GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 5, //  المسافه بينهم
                            mainAxisSpacing: 8, //  المسافه بينهم
                            childAspectRatio: 1,
                            mainAxisExtent: 180 //  المسافه بينهم
                            ),
                    itemCount: seriesApp.catindex3.length,
                    itemBuilder: (context, i) {
                      final chid = seriesApp.catindex3[i].channelId;
                      final ch_name = seriesApp.catindex3[i].channelName;
                      final ch_image = "$UrlApp$upload"
                          "${seriesApp.catindex3[i].channelImage}";
                      final chUrl = seriesApp.catindex3[i].channelUrl;
                      final ch_desc = seriesApp.catindex3[i].channelDescription;
                      final ch_type = seriesApp.catindex3[i].channelType;
                      final ch_videoid = seriesApp.catindex3[i].videoId;
                      final ctag_name = seriesApp.catindex3[i].categoryName;
                      final ch_useragent = seriesApp.catindex3[i].userAgent;
                      final web = detail3;
                      bool series = true;

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
                                series: series,
                                catid: widget.cid,
                                web: web));
                          }),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              // color: Colors.yellowAccent,
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: seriesApp.catindex3.isEmpty
                                          ? imagesloding
                                          : "$UrlApp$upload"
                                              "${seriesApp.catindex3[i].channelImage}",
                                      height: 150,
                                      imageBuilder: (context, imageProvider) =>
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
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "${seriesApp.catindex3[i].channelName}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              //////////////////////////////////////
            ),
          ],
        ),
      ),
    );
  }
}

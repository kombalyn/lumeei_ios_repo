// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, sized_box_for_whitespace, deprecated_member_use, unused_local_variable, duplicate_ignore, file_names

// Branch first commit comment

import 'package:admob_flutter/admob_flutter.dart';
import 'package:apptvshow/ads/adsWidget.dart';
import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/constant.dart';

import 'package:apptvshow/ads/ads_Model.dart';
import 'package:apptvshow/modelview/model_suggested.dart';

import 'package:apptvshow/sqldb/db.dart';
import 'package:apptvshow/sqldb/dbModelView.dart';

import 'package:apptvshow/videoplayer/playerYoutube.dart';
import 'package:apptvshow/videoplayer/vaido2.dart';
import 'package:apptvshow/videoplayer/vaido33.dart';
// import 'package:apptvshow/videoplayer/video_player.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:unity_ads_plugin/unity_ads_plugin.dart';
bool lisner = false;
bool start = false;
bool setapp = false;
bool player = false;
bool root = false;

class TvShow extends StatefulWidget {
  const TvShow(
      {super.key,
      this.chid,
      this.ch_name,
      this.ch_image,
      this.chUrl,
      this.ch_desc,
      this.ch_type,
      this.ch_videoid,
      this.ctag_name,
      this.web,
      this.ch_useragent,
      this.series,
      this.catid});

  final chid;
  final catid;
  final ch_name;
  final ch_image;
  final chUrl;
  final ch_desc;
  final ch_type;
  final ch_videoid;
  final web;
  final ctag_name;
  final ch_useragent;
  final series;

  @override
  State<TvShow> createState() => _TvShowState();
}

class _TvShowState extends State<TvShow> {
  SqlDb sqlDb = SqlDb();
  ModelSuggested modelSuggested = Get.put(ModelSuggested());
  Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
  DBModelView dbModelView = Get.put(DBModelView());
  // bool isIconSelected = false;
  @override
  void initState() {
    // print(widget.series);
    // ads_mOdel.getinterstitialAd();
    super.initState();
  }

  @override
  void dispose() {
    // ads_mOdel.interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.bgHome,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      height: 450,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.ch_image,
                        height: 450,
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
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                  widget.series != true
                      ? Positioned(
                          right: 10,
                          top: 30,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black.withOpacity(0.1),
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  Colors.red;
                                });
                                // ignore: unused_local_variable
                                if (widget.web == detail) {
                                  int resp = await dbModelView.insert(
                                      "ahmed",
                                      {
                                        "channelId": widget.chid,
                                        "channelName": widget.ch_name,
                                        "channelImage": widget.ch_image,
                                        "channelUrl": widget.chUrl,
                                        "channelType": widget.ch_type,
                                        "videoId": widget.ch_videoid,
                                        "channelDescription": widget.ch_desc,
                                        "categoryName": widget.ctag_name,
                                        "userAgent": widget.ch_useragent,
                                      },
                                      widget.chid);
                                } else {
                                  int resp2 = await dbModelView.insert2(
                                      "ch",
                                      {
                                        "channelId": widget.chid,
                                        "channelName": widget.ch_name,
                                        "channelImage": widget.ch_image,
                                        "channelUrl": widget.chUrl,
                                        "channelType": widget.ch_type,
                                        "videoId": widget.ch_videoid,
                                        "channelDescription": widget.ch_desc,
                                        "userAgent": widget.ch_useragent,
                                        "categoryName": widget.ctag_name
                                      },
                                      widget.chid);
                                }
                              },
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    dbModelView.ch(widget.chid, widget.web) ==
                                            true
                                        ? Colors.red
                                        : Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      : const Text(""),
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
                  Positioned(
                    bottom: 25,
                    left: 20,
                    child: Row(
                      children: [
                        GetBuilder<Ads_MOdel>(
                          init: Ads_MOdel(),
                          builder: (count) => InkWell(
                            onTap: () {
                              if (widget.ch_type == "URL") {
                                count.adsApp[0]['ad_status'] == "on"
                                    ? count.adsApp[0]['ad_type'] == "admob"
                                        ? count.interstitialAd.show()
                                        : count.showAd(
                                            "${count.unity_interstitial_placement_id}")
                                    : "";
                                Get.to(VideoApp222(
                                  link: widget.chUrl,
                                  userAgent: widget.ch_useragent,
                                ));
                              } else {
                                count.adsApp[0]['ad_status'] == "on"
                                    ? count.adsApp[0]['ad_type'] == "admob"
                                        ? count.interstitialAd.show()
                                        : count.showAd(
                                            "${count.unity_interstitial_placement_id}")
                                    : "";
                                Get.to(YouTubePlayer(
                                  videoid: widget.ch_videoid,
                                ));
                              }
                            },
                            child: Image.asset(
                              "images/go3.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Watch Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.ch_name,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.ctag_name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 20),
                  //   child: CircleAvatar(
                  //     radius: 25,
                  //     backgroundColor: Colors.black.withOpacity(0.3),
                  //     child: IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(
                  //         Icons.favorite,
                  //         color: Colors.white,
                  //         size: 30,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  widget.ch_type == "URL"
                      ? IconButton(
                          onPressed: () {
                            modelSuggested.share(widget.chUrl, widget.ch_name);
                          },
                          icon: const Icon(
                            Icons.share_rounded,
                            color: Colors.white,
                          ),
                        )
                      : const Text(""),
                ],
              ),
              // widget.ch_type == "URL"
              //     ? AdsApp(ads_mOdel: ads_mOdel)
              //     : const Text(""),
              // AdsApp(ads_mOdel: ads_mOdel),
              AdsFuture(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.ch_desc,
                  maxLines: 20,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      height: 1.5,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              widget.series != true
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Suggested ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : const Text(""),
              const SizedBox(
                height: 15,
              ),
              widget.series != true
                  ? suggested(modelSuggested: modelSuggested, widget: widget)
                  : suggested2(modelSuggested: modelSuggested, widget: widget)
            ],
          ),
        ));
  }
}

class AdsApp extends StatelessWidget {
  const AdsApp({
    super.key,
    required this.ads_mOdel,
  });

  final Ads_MOdel ads_mOdel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ads_mOdel.getAds(),
        builder: (context, snapshot) {
          return Container(
            // ignore: unrelated_type_equality_checks

            height: ads_mOdel.adsApp[0]["ad_status"] == "on" ? 55 : 0,
            width: double.infinity,
            // color: Colors.red,
            child: ads_mOdel.adsApp[0]["ad_type"] == "admob"
                ? AdmobBanner(
                    adUnitId: "${ads_mOdel.adsApp[0]["admob_banner_unit_id"]}",
                    adSize: AdmobBannerSize.BANNER,
                  )
                : Container(
                    height: 50,
                    color: Colors.red,
                  ),
          );
        });
  }
}

class suggested extends StatelessWidget {
  const suggested({
    super.key,
    required this.modelSuggested,
    required this.widget,
  });

  final ModelSuggested modelSuggested;
  final TvShow widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: modelSuggested.suggestedApp(widget.web, widget.chid),
      builder: (context, snapshot) => Container(
        height: 270,
        width: double.infinity,
        child: ListView.builder(
            itemCount: modelSuggested.movieshome.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final chUrl = modelSuggested.movieshome[i].channelUrl;
              final userAgent1 = modelSuggested.movieshome[i].userAgent;
              final chtype = modelSuggested.movieshome[i].channelType;
              final videoId = modelSuggested.movieshome[i].videoId;

              return GetBuilder<Ads_MOdel>(
                init: Ads_MOdel(),
                builder: (count) => InkWell(
                  onTap: () {
                    if (chtype == "URL") {
                      count.adsApp[0]['ad_status'] == "on"
                          ? count.adsApp[0]['ad_type'] == "admob"
                              ? count.interstitialAd.show()
                              : count.showAd(
                                  "${count.unity_interstitial_placement_id}")
                          : "";
                      Get.to(VideoApp222(
                        link: chUrl,
                        userAgent: userAgent1,
                      ));
                    } else {
                      count.adsApp[0]['ad_status'] == "on"
                          ? count.adsApp[0]['ad_type'] == "admob"
                              ? count.interstitialAd.show()
                              : count.showAd(
                                  "${count.unity_interstitial_placement_id}")
                          : "";
                      Get.to(YouTubePlayer(
                        videoid: videoId,
                      ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.yellow,
                      width: 150,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  imageUrl: modelSuggested.movieshome.isEmpty
                                      ? imagesloding
                                      : "$UrlApp$upload"
                                          "${modelSuggested.movieshome[i].channelImage}",
                                  height: 200,
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
                                      modelSuggested.movieshome.isEmpty
                                          ? "a"
                                          : "${modelSuggested.movieshome[i].categoryName}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 5,
                                child: Image.asset(
                                  "images/go3.png",
                                  height: 30,
                                  width: 30,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                modelSuggested.movieshome.isEmpty
                                    ? "a"
                                    : "${modelSuggested.movieshome[i].channelName}",
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
                ),
              );
            }),
      ),
    );
  }
}

class suggested2 extends StatelessWidget {
  const suggested2({
    super.key,
    required this.modelSuggested,
    required this.widget,
  });

  final ModelSuggested modelSuggested;
  final TvShow widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: modelSuggested.suggestedApp(widget.web, widget.chid),
      builder: (context, snapshot) => Container(
        height: 270,
        width: double.infinity,
        child: ListView.builder(
            itemCount: modelSuggested.movieshome.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final chUrl = modelSuggested.movieshome[i].channelUrl;
              final userAgent1 = modelSuggested.movieshome[i].userAgent;
              final chtype = modelSuggested.movieshome[i].channelType;
              final videoId = modelSuggested.movieshome[i].videoId;

              return GetBuilder<Ads_MOdel>(
                init: Ads_MOdel(),
                builder: (count) => InkWell(
                  onTap: () {
                    if (chtype == "URL") {
                      count.adsApp[0]['ad_status'] == "on"
                          ? count.adsApp[0]['ad_type'] == "admob"
                              ? count.interstitialAd.show()
                              : "UnityDAS"
                          : "";
                      Get.to(VideoApp222(
                        link: chUrl,
                        userAgent: userAgent1,
                      ));
                    } else {
                      count.adsApp[0]['ad_status'] == "on"
                          ? count.adsApp[0]['ad_type'] == "admob"
                              ? count.interstitialAd.show()
                              : "UnityDAS"
                          : "";
                      Get.to(YouTubePlayer(
                        videoid: videoId,
                      ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.yellow,
                      width: 150,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  imageUrl: modelSuggested.movieshome.isEmpty
                                      ? imagesloding
                                      : "$UrlApp$upload"
                                          "${modelSuggested.movieshome[i].channelImage}",
                                  height: 200,
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
                                      modelSuggested.movieshome.isEmpty
                                          ? "a"
                                          : "${modelSuggested.movieshome[i].categoryName}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 5,
                                child: Image.asset(
                                  "images/go3.png",
                                  height: 30,
                                  width: 30,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                modelSuggested.movieshome.isEmpty
                                    ? ""
                                    : "${modelSuggested.movieshome[i].channelName}",
                                maxLines: 1,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

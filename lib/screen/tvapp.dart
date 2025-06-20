// ignore_for_file: unnecessary_import, sort_child_properties_last

import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/constant.dart';
import 'package:apptvshow/modelview/modelTvCat_View.dart';
import 'package:apptvshow/screendetiels/detiels_CatogryTv.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class TvApp extends GetMaterialApp {
  TVCat tvCat = Get.put(TVCat());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.bgHome,
      body: GetBuilder<TVCat>(
        init: TVCat(),
        builder: (controller) => GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1, //  المسافه بينهم
              mainAxisSpacing: 8, //  المسافه بينهم
              childAspectRatio: 1,
              mainAxisExtent: 150,
            ),
            itemCount: controller.lastch.length,
            itemBuilder: (context, i) {
              final cid = controller.lastch[i].cid;
              final name = controller.lastch[i].categoryName;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (() {
                    Get.to(DEteilsCatagry(cid: cid, name: name));
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
                                imageUrl: controller.lastch.isEmpty
                                    ? imagesloding
                                    : "$UrlApp$upload2"
                                        "${controller.lastch[i].categoryImage}",
                                height: 90,
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
                            height: 15,
                          ),
                          Text(
                            "${controller.lastch[i].categoryName}",
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo'),
                          ),
                        ],
                      )),
                ),
              );
            }),
      ),
    );
  }
}

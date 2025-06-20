// ignore_for_file: file_names

import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/constant.dart';
import 'package:apptvshow/modelview/modelTvCat_View.dart';
// import 'package:apptvshow/screendetiels/detiels_CatogryMovies.dart';
import 'package:apptvshow/screendetiels/detilels_catogrySeries.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesApp extends StatelessWidget {
  const SeriesApp({super.key});

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
                crossAxisSpacing: 5, //  المسافه بينهم
                mainAxisSpacing: 8, //  المسافه بينهم
                childAspectRatio: 1,
                mainAxisExtent: 200),
            itemCount: controller.lastch3.length,
            itemBuilder: (context, i) {
              final cid = controller.lastch3[i].cid;
              final name = controller.lastch3[i].categoryName;
              final images = controller.lastch3[i].categoryImage;

              // SharedPreferences pro =
              //     SharedPreferences.getInstance() as SharedPreferences;
              // pro.setStringList('list', [category]);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (() {
                    Get.to(SeriesDetiles(
                      cid: cid,
                      name: name,
                      images: images,
                    ));

                    // Get.to(DEteilsCatagry2(cid: cid, name: name));
                  }),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: controller.lastch3.isEmpty
                                ? imagesloding
                                : "$UrlApp$upload2"
                                    "${controller.lastch3[i].categoryImage}",
                            height: 150,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter: const ColorFilter.mode(
                                  //     Colors.deepPurple,
                                  //     BlendMode.colorBurn),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Image.asset("images/3.jpg"),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${controller.lastch3[i].categoryName}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

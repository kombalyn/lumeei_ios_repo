// ignore_for_file: must_be_immutable, sized_box_for_whitespace, unused_local_variable, file_names

import 'package:apptvshow/constant.dart';
import 'package:apptvshow/modelview/modelTvCat_View.dart';
import 'package:apptvshow/modelview/viewHome.dart';
// import 'package:apptvshow/screen/tvShow.dart';
import 'package:apptvshow/screendetiels/detilels_catogrySeries.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

class SeriesHome extends StatelessWidget {
  SeriesHome({super.key});
  ViewHome viewHome = Get.put(ViewHome());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TVCat>(
      init: TVCat(),
      builder: (controller) {
        return controller.lastch3.isEmpty
            ? const Text("Loading...")
            : ListView.builder(
                itemCount: controller.lastch3.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  final cid = controller.lastch3[i].cid;
                  final name = controller.lastch3[i].categoryName;
                  final images = controller.lastch3[i].categoryImage;
                  const web = detail;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(SeriesDetiles(
                          cid: cid,
                          name: name,
                          images: images,
                        ));
                      },
                      child: Container(
                        // color: Colors.yellow,

                        width: 110,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.lastch3.isEmpty
                                        ? imagesloding
                                        : //"$UrlApp$upload2"
                                            "${controller.lastch3[i].categoryImage}",
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
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      color: Colors.red.withOpacity(0.3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        controller.lastch3.isEmpty
                                            ? "a"
                                            : "${controller.lastch3[i].categoryName}",
                                        style: const TextStyle(
                                            fontSize: 7,
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
                                  controller.lastch3.isEmpty
                                      ? "a"
                                      : "${controller.lastch3[i].categoryName}",
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

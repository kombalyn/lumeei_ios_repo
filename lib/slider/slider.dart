// ignore_for_file: non_constant_identifier_names

import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/modelview/viewHome.dart';
import 'package:apptvshow/screen/tvShow.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant.dart';

class Slider1 extends StatefulWidget {
  const Slider1({super.key});

  @override
  State<Slider1> createState() => _Slider1State();
}

class _Slider1State extends State<Slider1> {
  int myCurrentIndex = 0;
  ViewHome viewHome = Get.put(ViewHome());

  @override
  void initState() {
    viewHome.sliderhome();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.bgHome,
      body: SingleChildScrollView(
        child: GetBuilder<ViewHome>(
          init: ViewHome(),
          builder: (controller) => Column(
            children: [
              CarouselSlider.builder(
                itemCount: 10,
                itemBuilder: (context, i, realIndex) {
                  final chid = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].channelId;
                  final ch_name = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].channelName;
                  final ch_image = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : "$UrlApp$upload"
                          "${controller.moviesSlider[i].channelImage}";
                  final chUrl = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].channelUrl;
                  final ch_desc = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].channelDescription;
                  final ch_type = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].channelType;
                  final ch_videoid = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].videoId;
                  final ctag_name = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].categoryName;
                  final ch_useragent = controller.moviesSlider.isEmpty
                      ? imagesloding
                      : controller.moviesSlider[i].userAgent;

                  const web = detail;

                  return InkWell(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        imageUrl: controller.moviesSlider.isEmpty
                            ? imagesloding
                            : "$UrlApp$upload"
                                "${controller.moviesSlider[i].channelImage}",
                        width: 300,
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
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  height: 250,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  aspectRatio: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      myCurrentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AnimatedSmoothIndicator(
                activeIndex: myCurrentIndex,
                count: 10,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 10,
                  dotColor: Colors.grey.shade200,
                  activeDotColor: Colors.grey.shade900,
                  paintStyle: PaintingStyle.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

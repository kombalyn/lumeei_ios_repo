// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:apptvshow/constant.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IntroImageAnimated extends StatefulWidget {
  final bool isTv;
  final images1;
  const IntroImageAnimated({
    Key? key,
    this.isTv = false,
    this.images1,
  }) : super(key: key);

  @override
  State<IntroImageAnimated> createState() => _IntroImageAnimatedState();
}

class _IntroImageAnimatedState extends State<IntroImageAnimated> {
  late Timer timer;
  bool isImage = true;
  ScrollController controller = ScrollController();

  _startAnimation() async {
    const int second = 120;

    await Future.delayed(const Duration(milliseconds: 400));
    //debugPrint("start first one");

    await controller.animateTo(
      isImage ? controller.position.maxScrollExtent : 0,
      duration: const Duration(seconds: second),
      curve: Curves.linear,
    );

    // setState(() {
    //   isImage = !isImage;
    // });
    // await _startAnimation();
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    // timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = getSize(context).height / (widget.isTv ? 1 : 2);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: getSize(context).width,
          height: height,
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Image.asset(
              widget.images1,
              fit: BoxFit.cover,
              width: getSize(context).width + 140,
            ),

            // ),
          ),
          //  Image.network(
          //   widget.images1,
          //   fit: BoxFit.fill,
          //   width: getSize(context).width + 140,
          // ),
          // ),
        ),
        Opacity(
          opacity: widget.isTv ? 0.5 : .5,
          child: Container(
            width: getSize(context).width,
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black],
              ),
            ),
          ),
        ),
        if (!widget.isTv)
          const Column(
            children: [
              // Image.asset(
              //   kIconSplash,
              //   width: 40.w,
              //   height: 40.w,
              // ),
              // Text(
              //   kAppName.toUpperCase(),
              //   textAlign: TextAlign.center,
              //   style: Get.textTheme.headlineLarge!.copyWith(
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
      ],
    );
  }
}

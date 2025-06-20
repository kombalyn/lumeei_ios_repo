// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, library_private_types_in_public_api, avoid_print

// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:apptvshow/Navbar/navbar.dart';
// import 'package:apptvshow/color/colorapp.dart';

import 'package:apptvshow/ads/ads_Model.dart';
import 'package:apptvshow/constant.dart';

import 'package:apptvshow/modelview/modelTvCat_View.dart';
import 'package:apptvshow/modelview/viewHome.dart';
import 'package:apptvshow/screen/internet.dart';

import 'package:apptvshow/sqldb/dbModelView.dart';
import 'package:apptvshow/widget/inmay.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modelview/viewHome2.dart';

// import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ViewHome viewHome = Get.put(ViewHome());
  ViewHome2 viewHome2 = Get.put(ViewHome2());
  TVCat tvCat = Get.put(TVCat());
  Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
  DBModelView dbModelView = Get.put(DBModelView());
  goScreen() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAll(const InternetConnectionCheck());
    });
  }

  @override
  void initState() {
    goScreen();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // لفتح الاشعار والتوجه الى اى مكان تختاره
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      }));
    });

    ads_mOdel.getAds();
    viewHome.moviesHomeapp();
    viewHome2.moviesHomeapp();
    tvCat.getcat();
    viewHome.lastChHome();
    viewHome2.lastChHome();
    tvCat.getcat2();
    tvCat.getcat3();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingWidgt();
  }
}

class InternetConnectionCheck extends StatefulWidget {
  const InternetConnectionCheck({super.key});

  @override
  _InternetConnectionCheckState createState() =>
      _InternetConnectionCheckState();
}

class _InternetConnectionCheckState extends State<InternetConnectionCheck> {
  Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
  TVCat tvCat = Get.put(TVCat());
  DBModelView dbModelView = Get.put(DBModelView());

  Future<ConnectivityResult> checkConnectivity() async {
    return await Connectivity().checkConnectivity();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      future: checkConnectivity(),
      builder:
          (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // إذا كان الاستعلام قيد التنفيذ، يمكنك عرض تحميل أو شاشة انتظار هنا.
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          final connectivityResult = snapshot.data;

          if (connectivityResult == ConnectivityResult.wifi) {
            // ads_mOdel.getAds();
            // viewHome.moviesHomeapp();
            // tvCat.getcat();
            // viewHome.lastChHome();
            // tvCat.getcat2();
            return const MyApp1();
          } else if (connectivityResult == ConnectivityResult.mobile) {
            // ads_mOdel.getAds();
            // viewHome.moviesHomeapp();
            // viewHome.lastChHome();
            // tvCat.getcat();
            // tvCat.getcat2();
            return const MyApp1();
          } else if (connectivityResult == ConnectivityResult.none) {
            return const InterNetApp();
          }
        }

        return const Center(
            child: Text(
          "No Internet Connection",
          style: TextStyle(
              color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold),
        ));
      },
    );
  }
}

class LoadingWidgt extends StatelessWidget {
  const LoadingWidgt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const IntroImageAnimated(isTv: true, images1: images),
          SizedBox(
            width: getSize(context).width,
            height: getSize(context).height,
            // decoration: kDecorBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    width: getSize(context).height * .22,
                    height: getSize(context).height * .22,
                    image: const AssetImage('images/splash.png'),
                  ),
                ),
                const SizedBox(height: 10),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(appname),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

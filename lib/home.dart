// ignore_for_file: unrelated_type_equality_checks, sized_box_for_whitespace, non_constant_identifier_names, sort_child_properties_last

import 'dart:ui';

import 'package:apptvshow/ads/adsWidget.dart';
import 'package:apptvshow/ads/ads_Model.dart';
import 'package:apptvshow/color/colorapp.dart';

import 'package:apptvshow/modelview/viewHome.dart';
import 'package:apptvshow/widget/lastch2.dart';

import 'package:apptvshow/widget/search.dart';
import 'package:apptvshow/widget/lastch.dart';
import 'package:apptvshow/widget/moviesHome.dart';
import 'package:apptvshow/slider/slider.dart';
import 'package:apptvshow/widget/seriesHome.dart';
import 'package:apptvshow/widget/shownot.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth.dart';


class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
  ViewHome viewHome = Get.put(ViewHome());
  // var asd = FirebaseMessaging.instance;
  final GlobalKey<_HomeState> _regFormKey = GlobalKey<_HomeState>();


  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
  Widget _signOutButton(){
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("Logout"),
    );
  }

  @override
  void initState() {
    // viewHome.getdata('${ads_mOdel.topic}');
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   // لفتح الاشعار والتوجه الى اى مكان تختاره
    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //     return const SplashScreen();
    //   }));
    // });
    // FirebaseMessaging.instance.subscribeToTopic('${ads_mOdel.topic}');
    viewHome.getdata('${ads_mOdel.topic}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorApp.bgHome, // same colour as the app background
      statusBarIconBrightness: Brightness.light, // Adjusts the icon color for contrast
      statusBarBrightness: Brightness.dark, // iOS status bar brightness
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorApp.bgHome,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _signOutButton(),
              const SizedBox(
                height: 15,
              ),
              Container(color: Colors.red, height: 300, child: const Slider1()),
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: AppSearch(prolist: viewHome.movieshome),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color of the search bar
                      borderRadius: BorderRadius.circular(15), // Customize the radius
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: SearchBar(
                      hintText: 'Keresés',
                      backgroundColor: WidgetStateColor.resolveWith(
                            (states) => Colors.black38, // Custom background color
                      ),
                      textStyle: WidgetStateTextStyle.resolveWith(
                            (states) => const TextStyle(
                          color: Colors.white, // Custom text color
                          fontSize: 16, // Custom font size
                        ),
                      ),
                      hintStyle: WidgetStateTextStyle.resolveWith(
                            (states) => const TextStyle(
                          color: Colors.white // Custom hint text color
                        ),
                      ),
                      enabled: false, // Disable direct typing to allow interaction with search
                      trailing: <Widget>[
                        Tooltip(
                          child: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () => {},
                            color: Colors.white,
                          ),
                          message: "Keresés",
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Fizika",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(height: 280, child: MoviesHome()),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Matek",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(height: 280, child: LastCh()),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Tortenelem",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Container(height: 280, child: SeriesHome()),
              Container(height: 280, child: LastCh2()),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:admob_flutter/admob_flutter.dart';

import 'package:apptvshow/screen/splashscreen.dart';
import 'package:apptvshow/sqldb/dbModelView.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ViewHome viewHome = Get.put(ViewHome());
// TVCat tvCat = Get.put(TVCat());
DBModelView dbModelView = Get.put(DBModelView());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Admob.initialize();

  dbModelView.reddate();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
// navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print('تم استلام الرسالة في الخلفية: ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetTree(),
    );
  }
}

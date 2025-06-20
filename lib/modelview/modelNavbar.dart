// ignore_for_file: file_names

import 'package:apptvshow/home.dart';
import 'package:apptvshow/screen/tvapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelNavbar extends GetxController {
  Widget scrren = const Home();
  int index1 = 0;
  get index2 => index1;
  void selectindex(int select) {
    index1 = select;
    switch (index1) {
      case 0:
        {
          scrren = const Home();
          break;
        }
      case 1:
        {
          scrren = TvApp();
        }
      case 2:
        {
          scrren = const Home();
        }
    }
    update();
  }
}

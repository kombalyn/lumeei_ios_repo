// ignore_for_file: library_private_types_in_public_api, sort_child_properties_last

// import 'package:apptvshow/Navbar/menu_item.dart';
// import 'package:apptvshow/Navbar/slider.dart';
import 'package:apptvshow/Navbar/menu_item.dart';
import 'package:apptvshow/Navbar/slider.dart';
import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/screen/Series.dart';
import 'package:apptvshow/screen/favorite.dart';
import 'package:apptvshow/home.dart';
import 'package:apptvshow/screen/moviesapp.dart';
import 'package:apptvshow/screen/tvapp.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for DoubleBackToCloseApp

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: DoubleBackToCloseApp(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _listOfWidget,
        ),
        snackBar: const SnackBar(
          content: Text('Tap back again to Exit'),
        ),
      ),
      bottomNavigationBar: _buildCustomNavBar(),
    );
  }

  Widget _buildCustomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.black38,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home,  0),
          _buildNavItem(Icons.explore_outlined,  1),
          _buildNavItem(Icons.favorite_border_rounded,  2),
          _buildNavItem(Icons.account_circle_outlined,  3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        onButtonPressed(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.pinkAccent : Colors.white,
            size: isSelected ? 30 : 24,
          ),
        ],
      ),
    );
  }
}

List<Widget> _listOfWidget = <Widget>[
  const Home(),
  TvApp(),
  const MoviesApp(),
  const SeriesApp(),
  const Favorite()
];

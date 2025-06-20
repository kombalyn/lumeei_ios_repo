// ignore_for_file: sort_child_properties_last

import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/sqldb/movies.dart';
import 'package:apptvshow/sqldb/tv.dart';

import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ColorApp.bgHome,
          appBar: AppBar(
            title: const Text(
              "All Favorite",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.red,
              tabs: [
                Tab(
                  child: Text("Movies"),
                  icon: Icon(Icons.movie),
                ),
                Tab(
                  child: Text('Tv Ch',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  icon: Icon(Icons.tv),
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            Movies(),
            TV(),
          ]),
        ),
      ),
    );
  }
}

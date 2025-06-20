import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ShowNot extends StatefulWidget {
  const ShowNot({super.key});

  @override
  State<ShowNot> createState() => _ShowNotState();
}

class _ShowNotState extends State<ShowNot> {
  bool val2 = true;
  getdata(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('ahmed', val);
    // setState(() {
    //   val2 =
    // });
  }

  getdata1() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      val2 = pref.getBool('ahmed')!;
    });
  }

  @override
  void initState() {
    getdata1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 8, 8, 8),
      child: SwitchListTile(
          title: const Text(
            'Activate notifications',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            '',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          secondary: const Icon(
            Icons.notifications,
            color: Colors.yellow,
          ),
          isThreeLine: false,
          activeColor: Colors.red,
          selectedTileColor: Colors.green,
          shape:
              Border.all(width: 2, color: const Color.fromARGB(255, 14, 2, 1)),
          value: val2,
          onChanged: (val) async {
            // SharedPreferences pref = await SharedPreferences.getInstance();
            // _prefs.setBool('noor', val);
            getdata(val);

            setState(() {
              val2 = val;
            });
          }),
    );
  }
}

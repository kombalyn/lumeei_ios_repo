
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../auth.dart';
import '../color/colorapp.dart';

class LumeeiAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LumeeiAppbar({super.key});



  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorApp.bgHome,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset('images/LUMEEI_logó.jpg',
          width: 150,
          height: 150,
        ),
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: ElevatedButton(
            onPressed: signOut,
            style: ElevatedButton.styleFrom(
                backgroundColor:ColorApp.bgHome,
                foregroundColor: Colors.white,
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            child: const Text("Kijelentkezés"),
          ),
        ),
      ],
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


}



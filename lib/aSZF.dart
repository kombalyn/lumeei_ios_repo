
import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/login.dart';
import 'package:apptvshow/register.dart';
import 'package:apptvshow/texts/aszfDescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aszf extends StatelessWidget {
  const Aszf({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.white60,
                      foregroundColor: ColorApp.bgHome,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      )
                  ),
                  child: const SizedBox(
                      width: 80,
                      height: 50,
                      child: Center(child: Text("Regisztrálj a LUMEEI-ra"))
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:ColorApp.bgHome,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      )
                  ),
                  child: const Text("Bejelentkezés"),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_left,
                        size: 40,
                        color: Colors.black,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Vissza az előző oldalra",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Text("A LUMEEI felhasználási feltételei",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Text(aszfDescription,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          )
        )
    );
  }
}

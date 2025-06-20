import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/subscriptionOptions.dart';
import 'package:apptvshow/widget/lumeeiAppbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({super.key});

  @override
  State<Subscribe> createState() => _SubscribeState();

}

class _SubscribeState extends State<Subscribe> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/subjects_blue.jpg"), // Your background image
                    fit: BoxFit.cover, // Fill the entire background
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
              appBar: const LumeeiAppbar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text("Tanulj és játssz velünk már mától kezdve!",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                        Text("Már 4990 Ft havi díjtól. Bármikor lemondhatod.",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionOptions()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:ColorApp.bgHome,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                          ),
                            child: SizedBox(
                              width: 250,
                              height: 60,
                              child: Center(
                                child: Text("Előfizetés kiválasztása",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ]
          )
    );
  }
}


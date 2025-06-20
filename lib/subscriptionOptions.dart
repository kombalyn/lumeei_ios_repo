import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/home.dart';
import 'package:apptvshow/screen/splashscreen.dart';
import 'package:apptvshow/widget/lumeeiAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';



class SubscriptionOptions extends StatefulWidget {
  const SubscriptionOptions({super.key});

  @override
  State<SubscriptionOptions> createState() => _SubscriptionOptionsState();
}

class _SubscriptionOptionsState extends State<SubscriptionOptions> {
  String subPrice = "4990 Ft";

  ButtonStyle inactiveButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      side: const BorderSide(
        width: 0.5,
        color: Colors.black38,
      ),
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  ButtonStyle activeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor:ColorApp.bgHome,
    foregroundColor: Colors.white,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  Color inactiveSubTextColor = Colors.black54;
  Color activeSubTextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const LumeeiAppbar(),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child:  Center(
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    Text("Válaszd ki a neked megfelelő előfizetést.",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            if(subPrice != "5990 Ft"){
                              setState(() {
                                subPrice = "5990 Ft";
                              });
                            }
                          },
                          style: (subPrice == "5990 Ft") ? activeButtonStyle : inactiveButtonStyle,
                          child: SizedBox(
                            width: 70,
                            height: 100,
                            child: Center(
                              child: Text("Havi",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: (subPrice == "5990 Ft") ? activeSubTextColor : inactiveSubTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        ElevatedButton(
                          onPressed: (){
                            if(subPrice != "4990 Ft"){
                              setState(() {
                                subPrice = "4990 Ft";
                              });
                            }
                          },
                          style: (subPrice == "4990 Ft") ? activeButtonStyle : inactiveButtonStyle,
                          child: SizedBox(
                            width: 70,
                            height: 100,
                            child: Center(
                              child: Text("Éves",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: (subPrice == "4990 Ft") ? activeSubTextColor : inactiveSubTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Havi díj",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(subPrice,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )

                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Divider(
                      color: Colors.black38,
                      height: 5,
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Minta",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text("000000",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )

                      ],
                    ),
                    const SizedBox(height: 30,),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()),
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
        )
    );
  }
}

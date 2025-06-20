import 'package:apptvshow/aSZF.dart';
import 'package:apptvshow/ads/ads_Model.dart';
import 'package:apptvshow/color/colorapp.dart';
import 'package:apptvshow/login.dart';
import 'package:apptvshow/modelview/viewHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth.dart';
import './userservice.dart';



class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Ads_MOdel ads_mOdel = Get.put(Ads_MOdel());
  ViewHome viewHome = Get.put(ViewHome());
  final GlobalKey<_RegisterState> _regFormKey = GlobalKey<_RegisterState>();

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _userService = UserService();

  Future<void> createUserWithEmailAndPassword(name) async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      await _userService.saveUserData(name);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _onSignInPressed() {
    // Handle sign-in logic here
    print('Sign-in button pressed');
  }

  @override
  void initState() {
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/LUMEEI_logó.jpg',
                    width: 150,
                    height: 150,
                  ),
                  Text('LUMEEI',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  Text('Fiók Létrehozása',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      )
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
                    },
                    child: Text('Már van fiókod? Bejelentkezés itt.',
                        style: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        )
                    ),
                  ),
                  Form(key: _regFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('NÉV',
                          style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              )
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _controllerName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: 'Írd be a neved',
                              hintStyle: const TextStyle(
                                color: ColorApp.bgHome,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (String? value){
                              if(value == null || value.isEmpty) {
                                return 'Kérlek add meg a neved';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Text('EMAIL',
                          style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              )
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _controllerEmail,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: 'Add meg az e-mail címed',
                              hintStyle: const  TextStyle(
                                color: ColorApp.bgHome,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return 'Kérlek add meg az e-mail címed';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('JELSZÓ',
                          style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              )
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _controllerPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: 'Add meg a jelszavad',
                              hintStyle: const TextStyle(
                                color: ColorApp.bgHome,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return 'Kérlek adj meg érvényes jelszót';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Text('Elfelejtett jelszó esetén kattints ide!',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 4,),
                  ElevatedButton(
                    onPressed: () => {createUserWithEmailAndPassword(_controllerName.text)},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
                      fixedSize: WidgetStatePropertyAll(Size(200, 22)),
                    ),
                    child: Text('Regisztráció',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 7), // Space between buttons
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Aszf()),
                      );
                    },
                    child: Text('ÁSZF & Adatvédelmi tájékoztató',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 7,
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

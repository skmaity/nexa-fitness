import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_app/elements/frosted_glass.dart';
import 'package:health_app/elements/loadingdialog.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/elements/signup_controller.dart';
// import 'package:health_app/pages/loginsignup/SignUp.dart';
// import 'package:health_app/pages/loginsignup/signup_details.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => SignUp1State();
}

class SignUp1State extends State<SignUp1> {
  MyUrl ob = MyUrl();
  var sleep = 0.0;
  authWithNumber controller = Get.put(authWithNumber());

  Future<void> emailcheck(String email) async {
    Map data = {
      "email": email,
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}signup_check.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        controller.signUpWithNumber();
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  final GlobalKey<FormState> gk = GlobalKey();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/bg15f.jpg'), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FrostedGlass(
                  thehight: 400.0,
                  thewidth: MediaQuery.of(context).size.width / 1.2,
                  thechild: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FlickerAnimatedText('SIGNUP1',
                                        textStyle: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ])
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Form(
                              key: gk,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: email,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Email Required";
                                      } else if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$')
                                          .hasMatch(value)) {
                                        return "Please enter valid email";
                                      } else {
                                        return null;
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        focusColor:
                                            Colors.white.withOpacity(0.2),
                                        labelText: 'Enter Email',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'Email',
                                        fillColor: Colors.white54,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: controller.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "phone number Required";
                                      } else if (value.length != 10) {
                                        return "Please enter valid phone number";
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        focusColor:
                                            Colors.white.withOpacity(0.2),
                                        labelText: 'Enter phone number',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'phone number',
                                        fillColor: Colors.white54,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      primary: Colors.white.withOpacity(0.5)),
                                  onPressed: () async {
                                    if (gk.currentState!.validate()) {
                                      emailcheck(email.text);

                                      var pref =
                                          await SharedPreferences.getInstance();
                                      pref.setString("email", email.text);
                                      pref.setString(
                                          "phone", controller.number.text);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Enter Email id and Password");
                                    }
                                  },
                                  child: const Text('Submit')),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

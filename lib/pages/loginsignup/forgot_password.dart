import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/elements/frosted_glass.dart';
import 'package:health_app/elements/signup_controller.dart';
// import 'package:health_app/pages/otp.dart';
// import 'package:health_app/pages/loadingdialog.dart';
// import 'package:health_app/pages/otp.dart';
// import 'package:http/http.dart' as http;
// import 'package:health_app/pages/mainurl.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';

class ForGotPass extends StatefulWidget {
  const ForGotPass({super.key});

  @override
  State<ForGotPass> createState() => _ForGotPassState();
}

class _ForGotPassState extends State<ForGotPass> {
  var email;
  final GlobalKey<FormState> gk = GlobalKey();

  // Future<void> loginStatus(String phone) async {
  //   Map data = {
  //     "phone": phone,
  //   };
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return const LoadingDialog();
  //       });
  //   try {
  //     var response = await http.post(
  //         Uri.https(MyUrl.mainurl, MyUrl.suburl + "forgot_password_otp.php"),
  //         body: data);
  //     var jsondata = jsonDecode(response.body);
  //     if (jsondata["status"] == "true") {
  //       email = jsondata["email"];
  //       Navigator.pop(context);
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => otp_page(),
  //       ));
  //       Fluttertoast.showToast(
  //         msg: jsondata["msg"],
  //       );
  //     } else {
  //       Navigator.pop(context);
  //       Fluttertoast.showToast(
  //         msg: jsondata["msg"],
  //       );
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     Fluttertoast.showToast(
  //       msg: e.toString(),
  //     );
  //   }
  // }

  authWithNumber c = Get.put(authWithNumber());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                thehight: 300.0,
                thewidth: 350.0,
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
                                  FlickerAnimatedText('NUMBER',
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
                            child: TextFormField(
                              controller: c.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "NUMBER Required";
                                } else if (value.length != 10) {
                                  return "Enter a valid phone number";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  focusColor: Colors.white.withOpacity(0.2),
                                  labelText: 'Enter phone number',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'phone number',
                                  fillColor: Colors.white54,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
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
                                            BorderRadius.circular(10)),
                                    primary: Colors.white.withOpacity(0.5)),
                                onPressed: () {
                                  // loginStatus(c.number.text);
                                  c.signUpWithNumber();
                                },
                                child: const Text('Send OTP')),
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
    );
  }
}

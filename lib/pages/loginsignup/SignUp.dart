import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_app/elements/frosted_glass.dart';
import 'package:health_app/elements/loadingdialog.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/elements/signup_controller.dart';
import 'package:health_app/pages/navigation_bar_items/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  MyUrl ob = MyUrl();
  authWithNumber controller = Get.put(authWithNumber());

  Future<void> dataUpload(String email, String img_url, String name,
      String phone, String password) async {
    Map data = {
      "email": email,
      "img_url": img_url,
      "name": name,
      "phone": phone,
      "password": password,
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}student_signup.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        _completeLogin();
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

  var mail = "";
  var ph = "";
  void sPref() async {
    var pref = await SharedPreferences.getInstance();
    mail = pref.getString('email')!;
    ph = pref.getString('phone')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sPref();
  }

  void _completeLogin() async {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Navigation(),
      ),
    );
  }

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  GlobalKey<FormState> gk = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cnpass = TextEditingController();

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
                  thehight: 450.0,
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
                                    FlickerAnimatedText('SIGNUP',
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
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: gk,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "first name requird";
                                        }
                                        return null;
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.email),
                                          focusColor:
                                              Colors.white.withOpacity(0.2),
                                          labelText: 'Enter full name',
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          hintText: 'full name',
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: _obscureText1,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                              Icons.password_rounded),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscureText1 = !_obscureText1;
                                              });
                                            },
                                            child: Icon(_obscureText1
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                          ),
                                          labelText: 'Enter Password',
                                          hintText: 'Password',
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          fillColor: Colors.white54,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password Required";
                                        } else if (pass.text.length <= 5) {
                                          return 'Password must be atleast 6 Characters';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: pass,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: _obscureText2,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                              Icons.password_rounded),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscureText2 = !_obscureText2;
                                              });
                                            },
                                            child: Icon(_obscureText2
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                          ),
                                          labelText: 'Confirm Password',
                                          hintText: 'Confirm Password',
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          fillColor: Colors.white54,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password Required";
                                        } else if (pass.text != cnpass.text) {
                                          return 'Password dose not match';
                                        }
                                        return null;
                                      },
                                      controller: cnpass,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      primary: Colors.white.withOpacity(0.5)),
                                  onPressed: () async {
                                    if (gk.currentState!.validate()) {
                                      dataUpload(
                                          mail,
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                          name.text,
                                          ph,
                                          cnpass.text);
                                      var pref =
                                          await SharedPreferences.getInstance();
                                      pref.setString('name', name.text);
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

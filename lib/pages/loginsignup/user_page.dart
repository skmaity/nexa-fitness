import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/pages/navigation_bar_items/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../elements/loadingdialog.dart';
import 'email_input.dart';
import 'forgot_password.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  MyUrl ob = MyUrl();

  bool _obscureText = true;

  final GlobalKey<FormState> gk = GlobalKey();

  final user = TextEditingController();

  final pass = TextEditingController();

  var op = 1.0;

  var nameValue = "";

  var colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  _close() {
    Navigator.pop(context);
  }

  Future<void> loginStatus(String email, String password) async {
    Map data = {"email": email, "password": password};
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}student_login.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == "true") {
        _close();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Navigation()));

        void wheretogo() async {
          var pref = await SharedPreferences.getInstance();
          pref.setBool("login", true);
          pref.setString('email', user.text);
        }

        wheretogo();

        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        _close();
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(color: Colors.black87),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.05,
                            child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FlickerAnimatedText('LOGIN',
                                      textStyle: TextStyle(
                                          fontSize: width * 0.10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                                key: gk,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: user,
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
                                          prefixIcon: const Icon(Icons.email),
                                          focusColor:
                                              Colors.white.withOpacity(0.2),
                                          labelText: 'Enter Email',
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          hintText: 'Email',
                                          fillColor: Colors.white54,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0))),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                              Icons.password_rounded),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            child: Icon(_obscureText
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
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ForGotPass()),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "Forget Password?",
                                              style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  color: Colors.white60,
                                                  fontFamily:
                                                      'Montserrat-Regular',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont Have a Account? ",
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const SignUp1())));
                              },
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontFamily: 'Montserrat-Bold',
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (gk.currentState!.validate()) {
                            loginStatus(user.text, pass.text);
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Enter valid Email id and Password");
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          height: 55,
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

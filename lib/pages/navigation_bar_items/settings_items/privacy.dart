import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/elements/loadingdialog.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPage extends StatefulWidget {
  final String email;

  const PrivacyPage({super.key, required this.email});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  String dpSpf = "";
  void setShowDp(String val) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('showdp', val);
  }

  void getShowDp() async {
    var pref = await SharedPreferences.getInstance();

    if (pref.getString('showdp') != null) {
      if (pref.getString('showdp') == 'true') {
        setState(() {
          dp = true;
        });
      }
    }
  }

  showDp() {
    if (dp == true) {
      showdpUpdate(widget.email, 'true');
      setShowDp('true');
    } else {
      showdpUpdate(widget.email, 'false');
      setShowDp('false');
    }
  }

  _close() {
    Navigator.pop(context);
  }

  bool batch = false;
  bool dp = false;

  MyUrl ob = MyUrl();

  Future<void> showdpUpdate(String email, String showdp) async {
    Map data = {
      "email": email,
      "showdp": showdp,
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });

    try {
      var response = await http.post(Uri.http(ob.mainurl, "${ob.suburl}dp.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == 'true') {
        setShowDp(showdp);
        _close();
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
      _close();

      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  @override
  void initState() {
    getShowDp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const btnBg = Color.fromARGB(255, 13, 218, 167);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Theme.of(context).colorScheme.onSecondary,
                  Colors.black,
                  Colors.black
                ],
              ),
            ),
          ),
          Positioned(
            left: width * 0.03,
            top: height * 0.04,
            child: Row(
              children: [
                IconButton(
                    iconSize: 32,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Theme.of(context).colorScheme.onBackground),
                SizedBox(
                  width: width * 0.5,
                ),
                Text(
                  'Privacy',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 30,
                    fontFamily: 'Montserrat-Bold',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.10,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: width * 0.95,
              height: height * 0.90,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x4CFFFFFF),
                    blurRadius: 42,
                    offset: Offset(0, 4),
                    spreadRadius: 11,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.50,
                            child: Text(
                              'Allow others to see your batch',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            width: 60,
                            child: AnimatedToggleSwitch<bool>.dual(
                              current: batch,
                              first: false,
                              second: true,
                              spacing: 0.0,
                              borderWidth: 5.0,
                              style: batch
                                  ? const ToggleStyle(backgroundColor: btnBg)
                                  : const ToggleStyle(
                                      backgroundColor: Color(0xFFD9D9D9)),
                              onChanged: (value) {
                                setState(() {
                                  batch = value;
                                });
                              },
                              styleBuilder: (b) => const ToggleStyle(
                                  indicatorColor: Color(0xFF6E6E6E)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.50,
                            child: Text(
                              'Allow others to see your DP',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            width: 60,
                            child: AnimatedToggleSwitch<bool>.dual(
                              current: dp,
                              first: false,
                              second: true,
                              spacing: 0.0,
                              borderWidth: 5.0,
                              style: dp
                                  ? const ToggleStyle(backgroundColor: btnBg)
                                  : const ToggleStyle(
                                      backgroundColor: Color(0xFFD9D9D9)),
                              onChanged: (value) {
                                setState(() {
                                  dp = value;
                                });
                              },
                              styleBuilder: (d) => const ToggleStyle(
                                  indicatorColor: Color(0xFF6E6E6E)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showDp();
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF213739),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'save',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

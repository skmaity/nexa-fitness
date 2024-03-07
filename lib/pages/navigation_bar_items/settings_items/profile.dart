import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/image_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../loginsignup/user_page.dart';

class ProfilePage extends StatefulWidget {
  final String email;
  const ProfilePage({super.key, required this.email});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    sharedpref();
    super.initState();
  }

  void sharedpref() async {
    var pref = await SharedPreferences.getInstance();
    steps = pref.getInt('takensteps')!;
    kcl = steps * 0.04;
    if (pref.getString('confessName') != null) {
      confess = pref.getString('confessName')!;
    }
    getFinishedConfess(widget.email, confess);
  }

  MyUrl ob = MyUrl();
  String ph = "Loading...";
  String nm = "Loading...";
  String em = "Loading...";
  String imageUrl = "";

  int steps = 0;
  int kclval = 4;
  double kcl = 0;
  String confess = '';

  Future<void> profile(String email) async {
    Map data = {"email": email};
    try {
      var response = await http
          .post(Uri.http(ob.mainurl, "${ob.suburl}profile.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == 'true') {
        ph = jsondata["phone"];
        nm = jsondata["name"];
        em = jsondata["email"];
        imageUrl = jsondata["img_url"];
        _acbadge = jsondata["activebadge"];

        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        Fluttertoast.showToast(
          msg: jsondata['msg'],
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Future<void> activeBadgeUpdate(String email, String confess) async {
    Map data = {
      "email": email,
      "confess": confess,
    };
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}activebadgeUpdate.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        Fluttertoast.showToast(
          msg: jsondata['msg'],
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Future<void> getFinishedConfess(String email, String confess) async {
    Map data = {
      "email": email,
      "confess": confess,
    };
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}getFinished_confess.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        setState(() {
          badge = jsondata["confess"];
        });
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        Fluttertoast.showToast(
          msg: jsondata['msg'],
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  List badge = List.empty();
  String _acbadge = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: profile(widget.email),
          builder: (context, item) {
            return Container(
              width: width,
              height: height,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: [
                            Theme.of(context).colorScheme.onSecondary,
                            Colors.black,
                            Colors.black
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.05,
                    top: height * 0.05,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Image(
                                image: const AssetImage('lib/assets/arrow.png'),
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 32,
                            fontFamily: 'Montserrat-Bold',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: width * 0.025,
                    left: width * 0.025,
                    top: height * 0.10,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: width * 0.95,
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
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(const ImgPicker(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: ClipRRect(
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: imageUrl == ""
                                            ? const Image(
                                                image: AssetImage(
                                                    'lib/assets/blank_profile.jpg'),
                                                fit: BoxFit.cover,
                                              )
                                            : Image(
                                                image: NetworkImage(imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello ,',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 32,
                                      fontFamily: 'Montserrat-Bold',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    nm,
                                    style: TextStyle(
                                      fontSize: nm.length > 15 ? 27 : 40,
                                      fontFamily: 'Montserrat-Bold',
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Active badge',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 35,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    _acbadge,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Your badges',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.40,
                                width: width * 0.80,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          crossAxisCount: 4,
                                          childAspectRatio: 2.0),
                                  itemCount: badge.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _acbadge = badge[index];
                                          activeBadgeUpdate(
                                              widget.email, badge[index]);
                                        });
                                      },
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFD9D9D9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            badge[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserPage()),
                                  (Route<dynamic> route) => false);
                              var pref = await SharedPreferences.getInstance();
                              pref.setBool('login', false);
                              pref.setString('email', "");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                        fontSize: 24,
                                        fontFamily: 'Montserrat-Bold',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    ));
  }
}

import 'dart:convert';
import 'package:health_app/pages/navigation_bar_items/dash_items/water.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/pages/navigation_bar_items/ExistingConfessPage.dart';
import 'package:health_app/pages/navigation_bar_items/dash_items/NewConfessBox.dart';
import 'package:health_app/pages/navigation_bar_items/dash_items/dashmid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  MyUrl ob = MyUrl();

  @override
  void initState() {
    super.initState();
    sharedpref();
    waterReset();
  }

  waterReset() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getString('waterdate') != DateTime.daysPerWeek.toString() ||
        pref.getString('waterdate') == null) {
      pref.setDouble('water', 0.0);
    }
  }

  TextEditingController t = TextEditingController();
  String email = '';
  String name = "";

  void sharedpref() async {
    var pref = await SharedPreferences.getInstance();
    email = pref.getString('email')!;
    getconfess(email);

    if (pref.getString('bed') != null) {
      setState(() {
        stime = pref.getString('bed')!;
      });
    }
    if (pref.getString('wakeup') != null) {
      setState(() {
        wtime = pref.getString('wakeup')!;
      });
    }

    // name = pref.getString('name')!;
  }

  String stime = "";
  String wtime = "";
  bool confessFlagg = false;

  static const List<String> list = <String>['profile', 'Settings'];
  String dropdownValue = list.first;
  List confess = [];
  List days = [];

  // void _close() {
  //   Navigator.pop(context);
  // }

  Future<void> getconfess(String email) async {
    Map data = {"email": email};
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return const LoadingDialog();
    //     });
    try {
      var response = await http
          .post(Uri.http(ob.mainurl, "${ob.suburl}getconfess.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        setState(() {
          confess = jsondata["confess"];
          days = jsondata["days"];
        });
        confessFlagg = jsondata["status"];
        // _close();
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        // _close();
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  setWaterSPF(double water) async {
    var pref = await SharedPreferences.getInstance();
    double setWater = 0;

    var spfwater = pref.getDouble('water');
    if (spfwater == null) {
      setWater = water;
    } else {
      setWater = spfwater + water;
    }
    print(spfwater);

    pref.setDouble('water', setWater);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DashMidSection(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Text(
                      'Your Confession',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat-Bold',
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 110,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: confess.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExistingConfessPage(
                                        confess: '${confess[index]}',
                                        email: email,
                                      )),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 170,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topLeft,
                                              colors: [
                                                Colors.white.withOpacity(0.2),
                                                Colors.white.withOpacity(0.9),
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    // SizedBox(
                                    //   width: 30,
                                    //   child: Image.asset('lib/assets/plus.png'),
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${confess[index]}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat-Bold',
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const NewConfessBox(),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Text(
                      'Add records',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat-Bold',
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // setWaterSPF(1.0);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WaterAddPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 170,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topLeft,
                                              colors: [
                                                Colors.white.withOpacity(0.2),
                                                Colors.white.withOpacity(0.9),
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      child:
                                          Image.asset('lib/assets/glass.png'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Water',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat-Bold',
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Container(
                      //   width: 100,
                      //   height: 80,
                      //   decoration: BoxDecoration(
                      //     image: const DecorationImage(
                      //         image: AssetImage('lib/assets/glass.png')),
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      // ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    ));
  }
}

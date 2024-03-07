import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/elements/date_utils.dart' as date_utils;
import 'package:health_app/elements/loadingdialog.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/pages/navigation_bar_items/navigation.dart';
import 'package:http/http.dart' as http;

class ExistingConfessPage extends StatefulWidget {
  final String confess;
  final String email;

  const ExistingConfessPage(
      {super.key, required this.confess, required this.email});

  @override
  State<ExistingConfessPage> createState() => _ExistingConfessPageState();
}

class _ExistingConfessPageState extends State<ExistingConfessPage> {
  double height = 0;
  double width = 0;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List dates = [];
  List confess = [];
  String? days = 'Loading...';

  List colorsList = List.empty();
  backtodash() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  _close() {
    Navigator.pop(context);
  }

  listbuild() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    currentMonthList = date_utils.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort(((a, b) => a.day.compareTo(b.day)));
    currentMonthList = currentMonthList.toSet().toList();
    int monLen = currentMonthList.length - 1;
    int dbMonLen = dates.length - 1;
    colorsList = List.filled(monLen + 1, 0);

    for (int i = 0; i <= monLen; i++) {
      for (int j = 0; j <= dbMonLen; j++) {
        if (dates[j] + ' 00:00:00.000'.toString() ==
            currentMonthList[i].toString()) {
          if (confess[j] == 'true') {
            colorsList[i] = 1;
          }
        }
      }
    }
  }

  MyUrl ob = MyUrl();
  Future<void> getconfessStatus(String email, String confess_name) async {
    Map data = {"email": email, "confess_name": confess_name};

    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}getConfess_status.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        confess = jsondata["confess"];
        dates = jsondata["dates"];
        setState(() {});

        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
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

  Future<void> daysLeft(String email, String confess) async {
    Map data = {"email": email, "confess": confess};
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}confess_daysleft.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        days = jsondata["days"];
      } else {
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

  Future<void> daysUpdate(String email, String confess) async {
    Map data = {"email": email, "confess": confess};
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}confess_daysupdate.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
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

  Future<void> deleteConfess(String email, String confess) async {
    Map data = {
      "email": email,
      "confess": confess,
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}deleteConfess.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        _close();
        backtodash();

        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
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

  Future<void> uploadconfessStatus(
      String email, String confess, String confess_name) async {
    Map data = {
      "email": email,
      "confess": confess,
      "confess_name": confess_name
    };

    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}confess_status.php"),
          body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == 'true') {
        getconfessStatus(widget.email, widget.confess).whenComplete(
          () {
            listbuild();
          },
        );

        daysUpdate(widget.email, widget.confess).whenComplete(() {
          setState(() {
            daysLeft(widget.email, widget.confess);
          });
        });

        Fluttertoast.showToast(
          msg: 'success',
        );
      } else {
        Fluttertoast.showToast(
          msg: 'fail',
        );
      }
    } catch (e) {
      print(e.toString());

      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    getconfessStatus(widget.email, widget.confess).whenComplete(
      () {
        listbuild();
      },
    );
    daysLeft(widget.email, widget.confess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: height * 0.01,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  iconSize: 32,
                  onPressed: () {
                    _close();

                    backtodash();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Theme.of(context).colorScheme.onBackground),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  widget.confess,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Montserrat-Bold',
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  deleteConfess(widget.email, widget.confess);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                        child: Image(
                          image: AssetImage('lib/assets/clear.png'),
                        ),
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'Montserrat-Bold',
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: height * 0.05,
              )
            ],
          ),
          Row(children: [Text('Days Left ${days}')]),
          Column(
            children: [
              SizedBox(
                height: height * 0.70,
                child: Expanded(
                  child: GridView.builder(
                    itemCount: currentMonthList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 5),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: colorsList[index] == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.errorContainer),
                        child: Text(currentMonthList[index].day.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            )),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Did you quite ',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                    fontFamily: 'Montserrat-Bold'),
              ),
              Text(
                widget.confess,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                    fontFamily: 'Montserrat-Bold'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  uploadconfessStatus(widget.email, 'true', widget.confess);
                },
                child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Image(
                                image: AssetImage('lib/assets/check.png'))))),
              ),
              const SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {
                  uploadconfessStatus(widget.email, 'false', widget.confess);
                },
                child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Image(
                                image: AssetImage('lib/assets/cancel.png'))))),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

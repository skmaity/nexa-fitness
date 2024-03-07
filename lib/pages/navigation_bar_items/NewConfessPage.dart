import 'package:flutter/material.dart';
import 'package:health_app/elements/loadingdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:health_app/elements/mainurl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'navigation.dart';

class NewConfessPage extends StatefulWidget {
  const NewConfessPage({super.key});

  @override
  State<NewConfessPage> createState() => _NewConfessPageState();
}

class _NewConfessPageState extends State<NewConfessPage> {
  backtodash() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  _close() {
    Navigator.pop(context);
  }

  MyUrl ob = MyUrl();
  Future<void> confess(String email, String confess, String days) async {
    Map data = {"email": email, "confess": confess, "days": days};
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });
    try {
      var response = await http
          .post(Uri.http(ob.mainurl, "${ob.suburl}confess.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == true) {
        Navigator.pop(context);

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
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  String email = '';

  void emsharedpref() async {
    var pref = await SharedPreferences.getInstance();

    if (pref.getString('email') != null) {
      email = pref.getString('email')!;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    emsharedpref();
    super.initState();
  }

  int days = 7;
  TextEditingController t = TextEditingController();
  void sharedpref() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(
      'confessName',
      t.text,
    );
    print(pref.getString('confessName')!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _close();
                        backtodash();
                      },
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image(
                          image: const AssetImage('lib/assets/arrow.png'),
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 9,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        maxLength: 10,
                        controller: t,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Montserrat-Bold'),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'The 21/90 rule',
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat-Bold'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'The 21/90 rule states that it takes',
                  style:
                      TextStyle(fontSize: 17, fontFamily: 'Montserrat-Regular'),
                ),
                Text(
                  '21 days to make a habit and',
                  style:
                      TextStyle(fontSize: 17, fontFamily: 'Montserrat-Regular'),
                ),
                Text(
                  '90 days to make it a permanent',
                  style:
                      TextStyle(fontSize: 17, fontFamily: 'Montserrat-Regular'),
                ),
                Text(
                  'lifestyle change.',
                  style:
                      TextStyle(fontSize: 17, fontFamily: 'Montserrat-Regular'),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 150,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    days = days - 1;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 250, 65, 111)),
                  child: const Image(
                      image: AssetImage('lib/assets/minus-sign.png')),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(children: [
                Text(
                  ' $days',
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat-Regular',
                  ),
                ),
                const Text(
                  '  DAYS  ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat-Regular',
                  ),
                )
              ]),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () => setState(() {
                  days = days + 1;
                }),
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 250, 65, 111)),
                  child: const Image(image: AssetImage('lib/assets/plus.png')),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      days = 10;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Text(
                        '10',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Montserrat-Bold'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      days = 20;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Text(
                        '20',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Montserrat-Bold'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      days = 30;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Text(
                        '30',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Montserrat-Bold'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 220,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    sharedpref();
                    confess(email, t.text, days.toString());
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Text(
                        'Promiss',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Montserrat-Bold'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 10,
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

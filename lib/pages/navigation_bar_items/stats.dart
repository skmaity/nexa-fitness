import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../elements/loadingdialog.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  _close() {
    Navigator.pop(context);
  }

  MyUrl ob = MyUrl();

  String email = '';
  Future sharedpref() async {
    var pref = await SharedPreferences.getInstance();
    email = pref.getString('email') ?? '';
  }

  List names = [];
  List img = [];
  List scores = [];
  List showdp = [];
  List activebadgelist = [];

  Future<void> leaderboard(String email) async {
    Map data = {"email": email};
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });

    try {
      var response = await http
          .post(Uri.http(ob.mainurl, "${ob.suburl}stats.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == 'true') {
        setState(() {
          names = jsondata["name"];
          img = jsondata["img_url"];
          scores = jsondata["scores"];
          showdp = jsondata["showdp"];
          activebadgelist = jsondata["activebadge"];
        });
        _close();

        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      } else {
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
      }
    } catch (e) {
      _close();
      Fluttertoast.showToast(
        msg: e.toString(),
      );

      // Fluttertoast.showToast(
      //   msg: 'No internet',
      // );
    }
  }

  @override
  void initState() {
    super.initState();
    sharedpref().whenComplete(() {
      setState(() {
        leaderboard(email);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'SCORES',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontFamily: 'Montserrat-Bold',
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        index == 0
                            ? LottieBuilder(
                                lottie: AssetLottie(
                                  'lib/assets/stars.json',
                                ),
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(
                                width: 20,
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: showdp[index] == 'true'
                                  ? Image(
                                      image: NetworkImage(img[index] ??
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                      fit: BoxFit.cover,
                                    )
                                  : const Image(
                                      image: NetworkImage(
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${names[index]}',
                              style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 100,
                              height: 35,
                              decoration: ShapeDecoration(
                                color: Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  activebadgelist[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${scores[index]}',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

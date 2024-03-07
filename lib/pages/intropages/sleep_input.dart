// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:health_app/pages/intropages/notificationPanel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepInput extends StatefulWidget {
  const SleepInput({super.key});

  @override
  State<SleepInput> createState() => _InputsState();
}

class _InputsState extends State<SleepInput> {
  MyUrl ob = MyUrl();

  TextEditingController bed = TextEditingController();
  TextEditingController wakeup = TextEditingController();
  GlobalKey gk = GlobalKey();
  int step = 1000;
  TimeOfDay stime = const TimeOfDay(hour: 10, minute: 30);
  TimeOfDay wtime = const TimeOfDay(hour: 6, minute: 30);
  void TimePickerS() {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 30),
    ).then((value) {
      if (value != null) {
        setState(() {
          stime = value;
        });
      }
    });
  }

  void TimePickerw() {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 6, minute: 30),
    ).then((value) {
      if (value != null) {
        setState(() {
          wtime = value;
        });
      }
    });
  }

  void SetBedSPF() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(
      'bed',
      stime.format(context).toString(),
    );
    pref.setString(
      'wakeup',
      wtime.format(context).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.black87),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Your Daly\nBed Time",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Bold',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Set a time bassed on when you go to sleep",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "and how much sleep in enough, each day.",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white10)),
                            onPressed: () {
                              setState(() {
                                stime = const TimeOfDay(hour: 22, minute: 00);
                                wtime = const TimeOfDay(hour: 6, minute: 00);
                              });
                            },
                            child: const Text(
                              'Early',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white10)),
                            onPressed: () {
                              setState(() {
                                stime = const TimeOfDay(hour: 23, minute: 00);
                                wtime = const TimeOfDay(hour: 7, minute: 00);
                              });
                            },
                            child: const Text(
                              'Moderately',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white10)),
                            onPressed: () {
                              setState(() {
                                stime = const TimeOfDay(hour: 24, minute: 00);
                                wtime = const TimeOfDay(hour: 8, minute: 00);
                              });
                            },
                            child: const Text(
                              'Late',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(children: [
                        InkWell(
                          onTap: () {
                            TimePickerS();
                          },
                          child: Text(
                            stime.format(context).toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat-Regular',
                                color: Colors.white),
                          ),
                        ),
                        const Text(
                          'BED TIME',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        )
                      ]),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(children: [
                        InkWell(
                          onTap: () {
                            TimePickerw();
                          },
                          child: Text(
                            wtime.format(context).toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat-Regular',
                                color: Colors.white),
                          ),
                        ),
                        const Text(
                          'WAKE UP',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        )
                      ]),
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        SetBedSPF();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationPanel()),
                        );
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:health_app/elements/water_in.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigation.dart';

class WaterAddPage extends StatefulWidget {
  const WaterAddPage({super.key});

  @override
  State<WaterAddPage> createState() => _WaterAddPageState();
}

class _WaterAddPageState extends State<WaterAddPage> {
  double waterintake = 0;
  double targatewater = 0;
  double per = 0;
  double percentage = 0;

  backtodash() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  _close() {
    Navigator.pop(context);
  }

  waterAlert() {
    QuickAlert.show(
        context: context,
        text: 'water targate complete',
        title: 'water',
        type: QuickAlertType.success);
  }

  setPer() async {
    if (waterintake / targatewater < 1.0) {
      setState(() {
        per = waterintake / targatewater;
        percentage = per * 100;
      });
    } else {
      var pref = await SharedPreferences.getInstance();
      if (pref.getString('wateralertdate') != DateTime.daysPerWeek.toString()) {
        waterAlert();
      }
    }
  }

  waterSPF() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getDouble('water') != null) {
      waterintake = pref.getDouble('water')!;
    }

    if (pref.getDouble('targatewater') != null) {
      targatewater = pref.getDouble('targatewater')!;
    }
    setPer();
  }

  setWaterSPF(double water) async {
    double w = 0;
    var pref = await SharedPreferences.getInstance();
    if (pref.getDouble('water') != null) {
      w = pref.getDouble('water')!;
    }

    pref.setDouble('water', w + water);
    waterSPF();
    pref.setString('waterdate', DateTime.daysPerWeek.toString());
  }

  @override
  void initState() {
    super.initState();
    waterSPF();
  }

  TextEditingController water = TextEditingController();
  @override
  void dispose() {
    water.dispose();
    super.dispose();
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Others'),
            content: TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: water,
              decoration: const InputDecoration(
                  hintText: 'enter amount of water in ml'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    cancel();
                  },
                  child: const Text(
                    'cancel',
                  )),
              TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: const Text(
                    'submit',
                  )),
            ],
          ));

  submit() {
    setWaterSPF(double.parse(water.text) / 1000);

    Navigator.pop(context);
  }

  cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var waterc = const Color.fromARGB(255, 17, 196, 228);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 430,
              height: 932,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [
                    Color(0xFF1EE9C5),
                    Color(0xFF2D524C),
                    Colors.black,
                    Colors.black
                  ],
                ),
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
                      _close();
                      backtodash();
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Theme.of(context).colorScheme.onBackground),
                SizedBox(
                  width: width * 0.5,
                ),
                Text(
                  'Water',
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
            top: height * 0.10,
            child: Container(
              width: width * 0.95,
              height: height * 0.90,
              padding: const EdgeInsets.all(20),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF5C5C5C),
                              shape: OvalBorder(),
                            ),
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("lib/assets/water-drop.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Water\nToday',
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 85, 85),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: 120,
                        lineWidth: 20,
                        percent: per,
                        progressColor: waterc,
                        backgroundColor: waterc.withOpacity(0.4),
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(waterintake).toStringAsFixed(2)} L',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 85, 85, 85),
                                fontSize: 26,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 85, 85, 85),
                                fontSize: 26,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Quick Add',
                        style: TextStyle(
                          color: Color.fromARGB(255, 85, 85, 85),
                          fontSize: 26,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setWaterSPF(0.250);
                              setPer();
                            },
                            child: const WaterIn(
                              water: '250',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setWaterSPF(0.300);
                            },
                            child: const WaterIn(
                              water: '300',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setWaterSPF(0.500);
                            },
                            child: const WaterIn(
                              water: '500',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setWaterSPF(0.750);
                            },
                            child: const WaterIn(
                              water: '750',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setWaterSPF(1.0);
                            },
                            child: const WaterIn(
                              water: '1000',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              openDialog();
                            },
                            child: const WaterIn(
                              water: 'Other',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       width: 300,
                  //       height: 60,
                  //       decoration: ShapeDecoration(
                  //         color: const Color(0xFF213739),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30),
                  //         ),
                  //       ),
                  //       child: const Center(
                  //         child: Text(
                  //           'save',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 24,
                  //             fontFamily: 'Inter',
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

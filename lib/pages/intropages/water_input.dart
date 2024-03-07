import 'package:flutter/material.dart';
import 'package:health_app/pages/loginsignup/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterInput extends StatefulWidget {
  const WaterInput({super.key});

  @override
  State<WaterInput> createState() => _InputsState();
}

class _InputsState extends State<WaterInput> {
  double h = 0;
  double w = 0;
  double water = 3.0;
  void setWaterSPF() async {
    var pref = await SharedPreferences.getInstance();
    pref.setDouble(
      'targatewater',
      water,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  children: [
                    SizedBox(
                      height: height * 0.15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          "Your Daly\nWater Goal",
                          style: TextStyle(
                              fontSize: width * 0.08,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Bold',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Set a goal bassed on how much you",
                          style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "drink water, or how much water you'd\nlike to drink, each day.",
                          style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                )),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.white10)),
                            onPressed: () {
                              setState(() {
                                water = 4.0;
                              });
                            },
                            child: const Text(
                              'Lightly',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            )),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                )),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.white10)),
                            onPressed: () {
                              setState(() {
                                water = 6.0;
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
                        SizedBox(
                          width: width * 0.01,
                        ),
                        TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                )),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.white10)),
                            onPressed: () {
                              setState(() {
                                water = 8.0;
                              });
                            },
                            child: const Text(
                              'Highly',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            water = water - 1.0;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 228, 26, 76)),
                          child: const Image(
                              image: AssetImage('lib/assets/minus-sign.png')),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Column(children: [
                        Text(
                          ' $water',
                          style: TextStyle(
                              fontSize: width * 0.15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        ),
                        Text(
                          'LITERS/DAY',
                          style: TextStyle(
                              fontSize: width * 0.05,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        )
                      ]),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          water = water + 1.0;
                        }),
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 228, 26, 76)),
                          child: const Image(
                              image: AssetImage('lib/assets/plus.png')),
                        ),
                      ),
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setWaterSPF();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserPage()),
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

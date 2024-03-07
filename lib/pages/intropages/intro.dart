import 'package:flutter/material.dart';
import 'package:health_app/pages/intropages/steps_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    setWaterSPF();
    super.initState();
  }

  void setWaterSPF() async {
    var pref = await SharedPreferences.getInstance();
    pref.setDouble(
      'targatekcl',
      1000,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Colors.black87),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * 0.20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to NEXA",
                      style: TextStyle(
                          fontSize: width * 0.08,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat-Bold',
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.06,
                          child: const Image(
                              image: AssetImage('lib/assets/status.png')),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "See Your Activity",
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Bold',
                                  color: Colors.white),
                            ),
                            Text(
                              "Keep up with your rings, workouts, awards,\nand trends.",
                              style: TextStyle(
                                  fontSize: width * 0.022,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.06,
                      child: const Image(
                          image: AssetImage('lib/assets/applogo.png')),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Learn About NEXA",
                          style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Bold',
                              color: Colors.white),
                        ),
                        Text(
                          "Explore workouts and maditationsfor all levels from\nworld's top trainers.",
                          style: TextStyle(
                              fontSize: width * 0.022,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.06,
                          child: const Image(
                              image: AssetImage('lib/assets/send.png')),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Share With Others",
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Bold',
                                  color: Colors.white),
                            ),
                            Text(
                              "cheer on your friends as all of you chose your\nrings.",
                              style: TextStyle(
                                  fontSize: width * 0.022,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat-Regular',
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StepsInput()),
                    );
                  },
                  child: Container(
                    height: 55,
                    width: width * 0.90,
                    margin: const EdgeInsets.only(bottom: 40),
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
    );
  }
}

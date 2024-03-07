import 'package:flutter/material.dart';
import 'package:health_app/pages/intropages/water_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsInput extends StatefulWidget {
  const StepsInput({super.key});

  @override
  State<StepsInput> createState() => _InputsState();
}

class _InputsState extends State<StepsInput> {
  double h = 0;
  double w = 0;

  int step = 2000;
  void setStepSPF() async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(
      'steps',
      step,
    );
    print(pref.getInt('steps'));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Colors.black87),
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
                      width: width * 0.02,
                    ),
                    Text(
                      "Your Daly\nMove Goal",
                      style: TextStyle(
                          fontSize: width * 0.08,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat-Bold',
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
                    Text(
                      "Set a goal bassed on how active you are, or",
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
                      "how active you'd like to be, each day.",
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
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            )),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white10)),
                        onPressed: () {
                          setState(() {
                            step = 4000;
                            setStepSPF();
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
                      width: width * 0.02,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            )),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white10)),
                        onPressed: () {
                          setState(() {
                            step = 6000;
                            setStepSPF();
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
                      width: width * 0.02,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            )),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white10)),
                        onPressed: () {
                          setState(() {
                            step = 10000;
                            setStepSPF();
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
                        step = step - 5;
                        setStepSPF();
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
                      ' $step',
                      style: TextStyle(
                          fontSize: width * 0.15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat-Regular',
                          color: Colors.white),
                    ),
                    Text(
                      'STEPS/DAY',
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
                      step = step + 5;
                      setStepSPF();
                    }),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 228, 26, 76)),
                      child:
                          const Image(image: AssetImage('lib/assets/plus.png')),
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
                    setStepSPF();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WaterInput()),
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
    );
  }
}

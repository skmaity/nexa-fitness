import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInput extends StatefulWidget {
  const EditInput({super.key});

  @override
  State<EditInput> createState() => _EditInputState();
}

class _EditInputState extends State<EditInput> {
  @override
  void initState() {
    getSteps();
    getWater();
    super.initState();
  }

  int step = 0;
  void getSteps() async {
    var pref = await SharedPreferences.getInstance();
    step = pref.getInt(
      'steps',
    )!;
    setState(() {});

    print(pref.getInt('steps'));
  }

  void setStepSPF() async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(
      'steps',
      step,
    );
    print(pref.getInt('steps'));
  }

  double water = 0.0;

  void getWater() async {
    var pref = await SharedPreferences.getInstance();
    water = pref.getDouble(
      'targatewater',
    )!;
  }

  void setWaterSPF() async {
    var pref = await SharedPreferences.getInstance();
    pref.setDouble(
      'targatewater',
      water,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 430,
                    height: 932,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
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
                  top: height * 0.045,
                  child: Row(
                    children: [
                      IconButton(
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: Theme.of(context).colorScheme.onBackground),
                      SizedBox(
                        width: width * 0.5,
                      ),
                      Text(
                        'Inputs',
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
                    padding: EdgeInsets.all(20),
                    width: width * 0.95,
                    height: height * 0.90,
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      shadows: [
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
                        Container(
                          height: height * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Text(
                              'STEPS',
                              style: TextStyle(
                                fontSize: width * 0.10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat-Regular',
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        )),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white10)),
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
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        )),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white10)),
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
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        )),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white10)),
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              255, 228, 26, 76)),
                                      child: const Image(
                                          image: AssetImage(
                                              'lib/assets/minus-sign.png')),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              255, 228, 26, 76)),
                                      child: const Image(
                                          image: AssetImage(
                                              'lib/assets/plus.png')),
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Container(
                          height: height * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Text(
                                'WATER',
                                style: TextStyle(
                                    fontSize: width * 0.10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat-Regular',
                                    color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          )),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white10)),
                                      onPressed: () {
                                        setState(() {
                                          water = 4.0;
                                          setWaterSPF();
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
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          )),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white10)),
                                      onPressed: () {
                                        setState(() {
                                          water = 6.0;
                                          setWaterSPF();
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
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          )),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white10)),
                                      onPressed: () {
                                        setState(() {
                                          water = 8.0;
                                          setWaterSPF();
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
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          water = water - 1.0;
                                          setWaterSPF();
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color.fromARGB(
                                                255, 228, 26, 76)),
                                        child: const Image(
                                            image: AssetImage(
                                                'lib/assets/minus-sign.png')),
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
                                        setWaterSPF();
                                      }),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color.fromARGB(
                                                255, 228, 26, 76)),
                                        child: const Image(
                                            image: AssetImage(
                                                'lib/assets/plus.png')),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

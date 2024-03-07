import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => StepsState();
}

class StepsState extends State<Steps> {
  late Stream<StepCount> _sc;
  late Stream<PedestrianStatus> _pd;
  int _step = 0;
  int _tsteps = 0;
  double stepPer = 0.0;
  double waterPer = 0.0;

  String email = "";
  double waterintake = 0;
  double targateWater = 0;

  double targatekcl = 0;
  double burnkcl = 0;
  double kclPer = 0;
  double kcl = 0;

  int st = 0;
  int tc = 0;
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    sharedpref();
    reqPermission();
    waterSPF();
    kclSPF();
    scoresUpdateSFP(0);
  }

  setWaterSPF(double water) async {
    double w = 0;
    var pref = await SharedPreferences.getInstance();
    if (pref.getDouble('water') != null) {
      w = pref.getDouble('water')!;
    }

    pref.setDouble('water', w + water);
    pref.setString('waterdate', "${today.day}");
    _close();
  }

  waterAlert() {
    QuickAlert.show(
        context: context,
        text: 'Your targate completed\nDo you want to add more 500 ml',
        title: 'WATER',
        cancelBtnText: 'CANCEL',
        confirmBtnText: 'OK',
        onConfirmBtnTap: () {
          setWaterSPF(500.0);
        },
        onCancelBtnTap: () {
          _close();
        },
        type: QuickAlertType.confirm);
  }

  kclSPF() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getDouble('kcl') != null) {
      burnkcl = pref.getDouble('kcl')!;
    }
    if (pref.getDouble('targatekcl') != null) {
      targatekcl = pref.getDouble('targatekcl')!;
    }
    kcltargetCompleteCheck();
  }

  waterSPF() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getDouble('water') == null) {
      waterintake = 0;
    } else {
      waterintake = pref.getDouble('water')!;
    }
    if (pref.getDouble('targatewater') != null) {
      targateWater = pref.getDouble('targatewater')!;
    }
    watertargetCompleteCheck();
  }

  _close() {
    Navigator.pop(context);
  }

  void sharedpref() async {
    var pref = await SharedPreferences.getInstance();
    _tsteps = pref.getInt('steps')!;
    email = pref.getString('email')!;
  }

  void setStepSPF(int step) async {
    var pref = await SharedPreferences.getInstance();
    _tsteps = pref.getInt('steps')!;
    pref.setInt(
      'steps',
      _tsteps + step,
    );

    _tsteps = pref.getInt('steps')!;
    _close();
  }

  void stepUpdateSFP() async {
    var pref = await SharedPreferences.getInstance();

    pref.setInt('takensteps', _step);
    pref.setDouble(
      'kcl',
      _step * 0.04,
    );
    kcl = _step * 0.04;
  }

  void scoresUpdateSFP(int score) async {
    var pref = await SharedPreferences.getInstance();

    if (pref.getInt('takensteps') != null) {
      st = pref.getInt('takensteps')!;
    }
    int sc = st * 3 + score;
    pref.setInt('scores', sc);
    pref.setString('scoresdate', "${today.day}");
    dataUpload(email, sc.toString());
    print('data upload');
  }

  MyUrl ob = MyUrl();

  Future<void> dataUpload(
    String email,
    String scores,
  ) async {
    Map data = {
      "email": email,
      "scores": scores,
    };
    try {
      var response = await http.post(
          Uri.http(ob.mainurl, "${ob.suburl}data_upload.php"),
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

  stepalertCount() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('stepalertdate', "${today.day}");
  }

  wateralertCount() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('wateralertdate', "${today.day}");
  }

  kclalertCount() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('kclAlertdate', "${today.day}");
  }

  steptargetCompleteCheck(int st) async {
    if (st / _tsteps < 1.0) {
      stepPer = _step / _tsteps;
    } else {
      var pref = await SharedPreferences.getInstance();
      if (pref.getString('stepalertdate') != "${today.day}") {
        QuickAlert.show(
            context: context,
            text: 'step targate complete',
            title: 'steps',
            type: QuickAlertType.success);
        stepalertCount();
        // dataUpload(email, 500);
        scoresUpdateSFP(500);
      }
    }
  }

  watertargetCompleteCheck() async {
    if (waterintake / targateWater < 1.0) {
      waterPer = waterintake / targateWater;
    } else {
      var pref = await SharedPreferences.getInstance();
      if (pref.getString('wateralertdate') != "${today.day}") {
        QuickAlert.show(
            context: context,
            text: 'water targate complete',
            title: 'water',
            type: QuickAlertType.success);
        wateralertCount();
        // dataUpload(email, 500);
        scoresUpdateSFP(500);
      }
    }
  }

  kcltargetCompleteCheck() async {
    if (burnkcl / targatekcl < 1.0) {
      kclPer = burnkcl / targatekcl;
    } else {
      var pref = await SharedPreferences.getInstance();
      if (pref.getString('kclAlertdate') != "${today.day}") {
        QuickAlert.show(
            context: context,
            text: 'kcl targate complete',
            title: 'calories',
            type: QuickAlertType.success);
        kclalertCount();
        // dataUpload(email, 500);
        scoresUpdateSFP(500);
      }
    }
  }

  void onStepCount(StepCount event) {
    setState(() {
      _step = event.steps;
    });
    stepUpdateSFP();
    steptargetCompleteCheck(_step);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    scoresUpdateSFP(0);
  }

  void onPedestrianStatusError(error) {}

  void onStepCountError(error) {
    Fluttertoast.showToast(
      msg: 'Step Count not available',
    );
  }

  void initPlatformState() {
    _pd = Pedometer.pedestrianStatusStream;
    _pd.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

    _sc = Pedometer.stepCountStream;
    _sc.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future<void> reqPermission() async {
    PermissionStatus status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      initPlatformState();
    }
  }

  var move = const Color.fromARGB(255, 255, 29, 85);
  var kclColor = const Color.fromARGB(255, 18, 233, 108);
  var water = const Color.fromARGB(255, 17, 196, 228);

  void showalert(QuickAlertType quickAlertType, String title, String text) {
    QuickAlert.show(
        context: context, text: text, title: title, type: quickAlertType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Move",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat-Bold',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '$_step',
                    style: TextStyle(
                      color: move,
                      fontSize: 15,
                      fontFamily: 'Montserrat-Bold',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "KCL",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat-Bold',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    kcl.toStringAsFixed(2),
                    style: TextStyle(
                      color: kclColor,
                      fontSize: 15,
                      fontFamily: 'Montserrat-Bold',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "water",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat-Bold',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${waterintake.toStringAsFixed(2)}L',
                    style: TextStyle(
                      color: water,
                      fontSize: 15,
                      fontFamily: 'Montserrat-Bold',
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularPercentIndicator(
                curve: Curves.bounceIn,
                circularStrokeCap: CircularStrokeCap.round,
                radius: 90,
                lineWidth: 20,
                percent: stepPer,
                progressColor: move,
                animateFromLastPercent: true,
                backgroundColor: move.withOpacity(0.4),
              ),
              CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                radius: 65,
                lineWidth: 20,
                percent: kclPer,
                progressColor: kclColor,
                backgroundColor: kclColor.withOpacity(0.4),
              ),
              CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                radius: 40,
                lineWidth: 20,
                percent: waterPer,
                progressColor: water,
                backgroundColor: water.withOpacity(0.4),
              ),
              const Positioned(
                top: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image(
                          image: AssetImage('lib/assets/right_arrow_step.png')),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image(
                          image: AssetImage('lib/assets/right_double.png')),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: 15,
                      width: 15,
                      child:
                          Image(image: AssetImage('lib/assets/up-arrow.png')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

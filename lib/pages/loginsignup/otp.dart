import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/elements/frosted_glass.dart';
import '../../elements/signup_controller.dart';

class otp_page extends StatefulWidget {
  final String email;

  const otp_page({
    super.key,
    required this.email,
  });

  @override
  State<otp_page> createState() => _otp_pageState();
}

class _otp_pageState extends State<otp_page> {
  authWithNumber controller = Get.put(authWithNumber());

  GlobalKey gk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/bg15f.jpg'), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FrostedGlass(
                  thehight: 300.0,
                  thewidth: 350.0,
                  thechild: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedTextKit(
                                  repeatForever: true,
                                  pause: const Duration(seconds: 2),
                                  totalRepeatCount: 5,
                                  animatedTexts: [
                                    TyperAnimatedText('OTP',
                                        textStyle: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ])
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            TextFormField(
                              controller: controller.otp,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  focusColor: Colors.white.withOpacity(0.2),
                                  labelText: 'OTP',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'OTP',
                                  fillColor: Colors.white54,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary: Colors.white.withOpacity(0.5)),
                                  onPressed: () async {
                                    controller.verifyMobileNumber();
                                    // var pref =
                                    //     await SharedPreferences.getInstance();
                                    // pref.setBool("login", true);
                                    // pref.setString("email", widget.email);
                                  },
                                  child: const Text('Chek OTP')),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

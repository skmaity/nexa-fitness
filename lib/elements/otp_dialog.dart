import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class OtpDialog extends StatelessWidget {
  final String user;
  const OtpDialog({Key? key, required this.user}) : super(key: key);

  static bool okkey = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 120,
            width: 220,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 73, 98, 105),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   "assets/images/grab.gif",
                //   height: 40,
                //   width: 40,
                // ),
                // CircularProgressIndicator(
                //     valueColor: AlwaysStoppedAnimation(
                //         Color.fromARGB(255, 255, 251, 0))),
                const Text(
                  'Your OTP is:',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),

                AnimatedTextKit(
                    pause: const Duration(seconds: 2),
                    totalRepeatCount: 5,
                    animatedTexts: [
                      TyperAnimatedText(user,
                          textStyle: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

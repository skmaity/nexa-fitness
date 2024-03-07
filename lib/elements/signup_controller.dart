// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/pages/loginsignup/SignUp.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class authWithNumber extends GetxController {
  bool otpmatch = false;

  TextEditingController number = TextEditingController();
  TextEditingController otp = TextEditingController();

  String verifyId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  void signUpWithNumber() async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+91${number.text}",
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            verifyId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
      Get.toNamed("/otp");
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }

  Future<int> verifyMobileNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId, smsCode: otp.text);

      await auth.signInWithCredential(credential);
      Get.toNamed("/nav");
      Get.toNamed(
        "/signup",
      );
      Get.to(SignUp(),
          transition: Transition.rightToLeft,
          curve: Curves.bounceIn,
          duration: const Duration(seconds: 1),
          preventDuplicates: true);

      Get.snackbar('', "Number verified");
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
    return 0;
  }
}

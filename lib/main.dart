import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/firebase_options.dart';
import 'package:health_app/pages/intropages/intro.dart';
import 'package:health_app/pages/loginsignup/SignUp.dart';
import 'package:health_app/pages/loginsignup/otp.dart';
import 'package:health_app/pages/navigation_bar_items/dashboard.dart';
import 'package:health_app/pages/navigation_bar_items/navigation.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/image_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}
//hello

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      home: const CheckState(),
      // home: Navigation(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/otp',
          page: () => const otp_page(
            email: '',
          ),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUp(),
        ),
        GetPage(
          name: '/dashb',
          page: () => const DashBoard(),
        ),
        GetPage(
          name: '/nav',
          page: () => const Navigation(),
        ),
        GetPage(
          name: '/imgpick',
          page: () => const ImgPicker(),
        ),
      ],
    );
  }
}

class CheckState extends StatefulWidget {
  const CheckState({super.key});

  @override
  State<CheckState> createState() => _CheckStateState();
}

class _CheckStateState extends State<CheckState> {
  ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    whereToGo();
    themeController.themeSet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void whereToGo() async {
    var pref = await SharedPreferences.getInstance();
    var isLogin = pref.getBool("login");
    pref.getString("email");
    pref.getString("img_url");
    pref.getString("name");
    pref.getString("phone");
    pref.getString("password");
    pref.getString("bed");
    pref.getString("wakeup");
    pref.getInt('takensteps');
    pref.getInt('steps');
    pref.getString('confessName');
    pref.getString('theme');
    pref.getDouble('water');
    pref.getDouble('targatewater');
    pref.getString('waterdate');
    pref.getString('stepalertdate');
    pref.getString('wateralertdate');
    pref.getString('kclAlertdate');
    pref.getInt('scores');
    pref.getString('scoresdate');
    pref.getInt('targatec');
    pref.getDouble('targatekcl');
    pref.getDouble('kcl');
    pref.getString('showdp');

    if (isLogin != null) {
      if (isLogin) {
        Navigator.pushReplacement(
            (context),
            MaterialPageRoute(
              builder: (context) => const Navigation(),
            ));
      } else {
        Navigator.pushReplacement(
            (context),
            MaterialPageRoute(
              builder: (context) => const Page1(),
            ));
      }
    } else {
      Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const Page1(),
          ));
    }
  }
}

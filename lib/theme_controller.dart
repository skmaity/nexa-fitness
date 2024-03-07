import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  void setTheme(String themeName) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('theme', themeName);
  }

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromRGBO(22, 32, 43, 1),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      background: Color.fromRGBO(22, 32, 43, 1),
      onBackground: Colors.white, // for text color
      primary: Color.fromRGBO(28, 41, 57, 1), // for appbar background color
      onPrimary: Color.fromRGBO(108, 120, 142, 1), // for appbar text color
      surface: Color.fromRGBO(36, 49, 64, 1), //for container color
      onSurface: Color.fromRGBO(218, 221, 228, 1), // for container text color
      secondary: Color.fromRGBO(
          35, 45, 57, 1), // for existing_confess date background-color

      onSecondary:
          Color.fromRGBO(58, 58, 58, 1), // for existing_confess date text color
      onError: Color.fromRGBO(177, 181, 189, 1),
      // for error text color
      error: Color.fromRGBO(71, 31, 43, 1),
      // for error background-color and done confess date color
      primaryContainer: Color.fromRGBO(217, 219, 227, 70),
      // for select icon background color
      secondaryContainer: Color.fromRGBO(28, 41, 57, 1),
// for secend container background color
      onPrimaryContainer: Color.fromRGBO(39, 54, 78, 1),
      // for non select icon color
      onSecondaryContainer:
          Color.fromRGBO(217, 219, 227, 1), // for container text color
    ),
  );

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white, // for scaffoldBackgroundColor
      onBackground: Color.fromRGBO(53, 52, 76, 1), // for text color
      primary: Colors.white,
      // for appbar background color
      onPrimary: Color.fromRGBO(180, 189, 206, 1), // for appbar text color
      surface: Color.fromRGBO(245, 246, 248, 1), //for container color
      onSurface: Color.fromRGBO(55, 52, 77, 1), // for container text color
      secondary: Color.fromRGBO(
          224, 227, 232, 1), // for existing_confess date background-color
      onSecondary: Color.fromRGBO(229, 229, 229, 1),
      onError: Color.fromRGBO(177, 181, 189, 1),
      // for error text color
      error: Color.fromRGBO(71, 31, 43, 1),
      // for error background-color and done confess date color
      primaryContainer: Color.fromRGBO(9, 142, 255, 1),
      // for select icon background color
      secondaryContainer: Color.fromRGBO(28, 41, 57, 1),
// for secend container background color
      onPrimaryContainer: Color.fromRGBO(180, 188, 204, 1),
      // for non select icon color
      onSecondaryContainer:
          Color.fromRGBO(217, 219, 227, 1), // for container text color
    ),
  );
  final ThemeData blueTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white, // for scaffoldBackgroundColor
      onBackground: Color.fromRGBO(53, 52, 76, 1), // for text color
      primary: Colors.white,
      // for appbar background color
      onPrimary: Color.fromRGBO(180, 189, 206, 1), // for appbar text color
      surface: Color.fromRGBO(245, 246, 248, 1), //for container color
      onSurface: Color.fromRGBO(55, 52, 77, 1), // for container text color
      secondary: Color.fromRGBO(
          224, 227, 232, 1), // for existing_confess date background-color
      onSecondary: Color.fromRGBO(32, 144, 255, 1),
      onError: Color.fromRGBO(177, 181, 189, 1),
      // for error text color
      error: Color.fromRGBO(71, 31, 43, 1),
      // for error background-color and done confess date color
      primaryContainer: Color.fromRGBO(9, 142, 255, 1),
      // for select icon background color
      secondaryContainer: Color.fromRGBO(28, 41, 57, 1),
// for secend container background color
      onPrimaryContainer: Color.fromRGBO(180, 188, 204, 1),
      // for non select icon color
      onSecondaryContainer:
          Color.fromRGBO(217, 219, 227, 1), // for container text color
    ),
  );
  //changing theme according to user
  changeTheme(String name) {
    if (name == 'dark') {
      setTheme(name);

      Get.changeTheme(darkTheme);

      Get.changeThemeMode(ThemeMode.dark);
    } else if (name == 'light') {
      setTheme(name);

      Get.changeThemeMode(ThemeMode.light);
      // setTheme(name);

      Get.changeTheme(lightTheme);
    } else if (name == 'blue') {
      Get.changeThemeMode(ThemeMode.light);

      Get.changeTheme(blueTheme);
      setTheme(name);
    } else if (name == 'pink') {
      Get.changeThemeMode(ThemeMode.light);

      Get.changeTheme(pinkTheme);
      setTheme(name);
    } else if (name == 'yellow') {
      Get.changeThemeMode(ThemeMode.light);

      Get.changeTheme(yellowTheme);
      setTheme(name);
    } else if (name == 'green') {
      Get.changeThemeMode(ThemeMode.light);

      Get.changeTheme(greenTheme);
      setTheme(name);
    }
  }

//sp changing themes according to saved data
  themeSet() async {
    String themeNamespf = "";

    var pref = await SharedPreferences.getInstance();

    if (pref.getString('theme') == null) {
      themeNamespf = 'light';
    } else {
      themeNamespf = pref.getString('theme')!;
    }
    if (themeNamespf == 'dark') {
      Get.changeThemeMode(ThemeMode.dark);
    } else if (themeNamespf == 'light') {
      Get.changeThemeMode(ThemeMode.light);
    } else if (themeNamespf == 'blue') {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(blueTheme);
    } else if (themeNamespf == 'pink') {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(pinkTheme);
    } else if (themeNamespf == 'yellow') {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(yellowTheme);
    } else if (themeNamespf == 'green') {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(greenTheme);
    }
  }

  final ThemeData greenTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white, // for scaffoldBackgroundColor
      onBackground: Color.fromRGBO(53, 52, 76, 1), // for text color
      primary: Colors.white,
      // for appbar background color
      onPrimary: Color.fromRGBO(180, 189, 206, 1), // for appbar text color
      surface: Color.fromRGBO(245, 246, 248, 1), //for container color
      onSurface: Color.fromRGBO(55, 52, 77, 1), // for container text color
      secondary: Color.fromRGBO(
          224, 227, 232, 1), // for existing_confess date background-color
      onSecondary: Colors.green,
      onError: Color.fromRGBO(177, 181, 189, 1),
      // for error text color
      error: Color.fromRGBO(71, 31, 43, 1),
      // for error background-color and done confess date color
      primaryContainer: Color.fromRGBO(9, 142, 255, 1),
      // for select icon background color
      secondaryContainer: Color.fromRGBO(28, 41, 57, 1),
// for secend container background color
      onPrimaryContainer: Color.fromRGBO(180, 188, 204, 1),
      // for non select icon color
      onSecondaryContainer:
          Color.fromRGBO(217, 219, 227, 1), // for container text color
    ),
  );

  final ThemeData pinkTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white, // for scaffoldBackgroundColor
      onBackground: Color.fromRGBO(53, 52, 76, 1), // for text color
      primary: Colors.white,
      // for appbar background color
      onPrimary: Color.fromRGBO(180, 189, 206, 1), // for appbar text color
      surface: Color.fromRGBO(245, 246, 248, 1), //for container color
      onSurface: Color.fromRGBO(55, 52, 77, 1), // for container text color
      secondary: Color.fromRGBO(
          224, 227, 232, 1), // for existing_confess date background-color
      onSecondary: Color.fromRGBO(255, 0, 125, 1),
      onError: Color.fromRGBO(177, 181, 189, 1),
      // for error text color
      error: Color.fromRGBO(71, 31, 43, 1),
      // for error background-color and done confess date color
      primaryContainer: Color.fromRGBO(9, 142, 255, 1),
      // for select icon background color
      secondaryContainer: Color.fromRGBO(28, 41, 57, 1),
// for secend container background color
      onPrimaryContainer: Color.fromRGBO(180, 188, 204, 1),
      // for non select icon color
      onSecondaryContainer:
          Color.fromRGBO(217, 219, 227, 1), // for container text color
    ),
  );

  final ThemeData yellowTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.white, // for scaffoldBackgroundColor
      onBackground: Color.fromRGBO(53, 52, 76, 1), // for text color
      primary: Colors.white,
      // for appbar background color
      onPrimary: Color.fromRGBO(180, 189, 206, 1), // for appbar text color
      surface: Color.fromRGBO(245, 246, 248, 1), //for container color
      onSurface: Color.fromRGBO(55, 52, 77, 1), // for container text color
      secondary: Color.fromRGBO(
          224, 227, 232, 1), // for existing_confess date background-color
      onSecondary: Color.fromRGBO(255, 215, 3, 1),
      onError: Color.fromRGBO(177, 181, 189, 1),
      // for error text color
      error: Color.fromRGBO(71, 31, 43, 1),
      // for error background-color and done confess date color
      primaryContainer: Color.fromRGBO(9, 142, 255, 1),
      // for select icon background color
      secondaryContainer: Color.fromRGBO(28, 41, 57, 1),
// for secend container background color
      onPrimaryContainer: Color.fromRGBO(180, 188, 204, 1),
      // for non select icon color
      onSecondaryContainer:
          Color.fromRGBO(217, 219, 227, 1), // for container text color
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/about.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/edit_input.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/privacy.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/profile.dart';
import 'package:health_app/pages/navigation_bar_items/settings_items/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var email;

    void sharedpref() async {
      var pref = await SharedPreferences.getInstance();
      email = pref.getString("email");
      print("$email email is for seetings");
    }

    sharedpref();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.22,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        email: email,
                      )),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ))),
            padding: const EdgeInsets.all(13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 20,
                    child: Image.asset(
                      'lib/assets/down-arrow.png',
                      color: Theme.of(context).colorScheme.onSurface,
                    ))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThemesPage()),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ))),
            padding: const EdgeInsets.all(13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Themes',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 20,
                    child: Image.asset(
                      'lib/assets/down-arrow.png',
                      color: Theme.of(context).colorScheme.onSurface,
                    ))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditInput()),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ))),
            padding: const EdgeInsets.all(13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Edit input',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 20,
                    child: Image.asset(
                      'lib/assets/down-arrow.png',
                      color: Theme.of(context).colorScheme.onSurface,
                    ))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PrivacyPage(
                        email: email,
                      )),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ))),
            padding: const EdgeInsets.all(13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Privacy',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 20,
                    child: Image.asset(
                      'lib/assets/down-arrow.png',
                      color: Theme.of(context).colorScheme.onSurface,
                    ))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ))),
            padding: const EdgeInsets.all(13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 20,
                    child: Image.asset(
                      'lib/assets/down-arrow.png',
                      color: Theme.of(context).colorScheme.onSurface,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

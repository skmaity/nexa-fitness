import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/theme_controller.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
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
          Positioned(
            left: width * 0.03,
            top: height * 0.04,
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
                  width: width * 0.3,
                ),
                Text(
                  'App Theme',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 30,
                    fontFamily: 'Montserrat-Bold',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.10,
            left: width * 0.025,
            right: width * 0.025,
            child: Container(
              width: width * 0.95,
              height: height,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x6BFFFFFF),
                    blurRadius: 100,
                    offset: Offset(0, 4),
                    spreadRadius: 15,
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            themeController.changeTheme('dark');
                          },
                          child: Container(
                            height: height * 0.075,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  image: AssetImage('lib/assets/dark.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Dark Theme',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat-Bold',
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            themeController.changeTheme('light');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.075,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  image: AssetImage('lib/assets/light.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Light Theme',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat-Bold',
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          'Classic Themes',
                          style: TextStyle(
                            fontFamily: 'Montserrat-Bold',
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SizedBox(
                      width: width * 0.82,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                themeController.changeTheme('blue');
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              themeController.changeTheme('pink');
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              themeController.changeTheme('yellow');
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              themeController.changeTheme('green');
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green[400],
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [

                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

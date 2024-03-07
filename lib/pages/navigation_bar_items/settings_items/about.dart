import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [
                          Color(0xFF1EE9C5),
                          Color(0xFF2D524C),
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
                          icon: Icon(Icons.arrow_back),
                          color: Theme.of(context).colorScheme.onBackground),
                      SizedBox(
                        width: width * 0.5,
                      ),
                      Text(
                        'About',
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
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          'Welcome to the About page of Nexa, My passion for health and technology inspired me to create this app, aimed at helping you achieve your fitness goals effortlessly. With a commitment to innovation and user-centric design, i am here to support your fitness journey every step of the way. Thank you for choosing us to be your fitness companion.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          ' Developed by shubha kumar maity, led by the guidance of cclms collage',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Image(
                              image: AssetImage('lib/assets/nexa_logo.png'),
                              color:
                                  Theme.of(context).colorScheme.onBackground),
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

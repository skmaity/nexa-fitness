import 'package:flutter/material.dart';

class ExistingConfessBox extends StatefulWidget {
  const ExistingConfessBox({super.key});

  @override
  State<ExistingConfessBox> createState() => _ExistingConfessBoxState();
}

class _ExistingConfessBoxState extends State<ExistingConfessBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ExistingConfessPage()),
            // );
          },
          child: Container(
            height: 100,
            width: 170,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red.withOpacity(0.1),
                      Colors.red.withOpacity(0.3),
                    ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.9),
                              ]),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    // SizedBox(
                    //   width: 30,
                    //   child: Image.asset('lib/assets/plus.png'),
                    // ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Confess',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat-Bold',
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

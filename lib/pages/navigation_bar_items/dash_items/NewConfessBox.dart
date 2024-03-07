import 'package:flutter/material.dart';
import 'package:health_app/pages/navigation_bar_items/NewConfessPage.dart';

class NewConfessBox extends StatefulWidget {
  const NewConfessBox({super.key});

  @override
  State<NewConfessBox> createState() => _NewConfessBoxState();
}

class _NewConfessBoxState extends State<NewConfessBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewConfessPage()),
            );
          },
          child: Container(
            height: 100,
            width: 170,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.surface),
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
                    SizedBox(
                      width: 20,
                      child: Image.asset('lib/assets/plus.png'),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Confess',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat-Bold',
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

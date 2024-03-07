import 'package:flutter/material.dart';

class BetterSleepMsg extends StatefulWidget {
  const BetterSleepMsg({super.key});

  @override
  State<BetterSleepMsg> createState() => _BetterSleepMsgState();
}

class _BetterSleepMsgState extends State<BetterSleepMsg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your sleep quality",
                style: TextStyle(fontSize: 20, fontFamily: 'Montserrat-Bold'),
              ),
              Text(
                "slightly beter then yesterday",
                style:
                    TextStyle(fontSize: 20, fontFamily: 'Montserrat-Regular '),
              ),
            ],
          ),
          Row(
            children: [
              CircularProgressIndicator(
                value: 0.5,
                valueColor: AlwaysStoppedAnimation(Colors.greenAccent[200]),
              )
            ],
          )
        ],
      ),
    );
  }
}

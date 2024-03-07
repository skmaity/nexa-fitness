import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SleepTrack extends StatefulWidget {
  const SleepTrack({super.key});

  @override
  State<SleepTrack> createState() => _SleepTrackState();
}

class _SleepTrackState extends State<SleepTrack> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 100,
          lineWidth: 33,
          percent: 0.4,
          progressColor: Colors.deepPurple,
          backgroundColor: Colors.deepPurple.shade100,
          circularStrokeCap: CircularStrokeCap.round,
          center: const Text(
            'sleep',
            style: TextStyle(
                fontFamily: 'Montserrat-Bold',
                fontSize: 20,
                color: Colors.white),
          ),
        ),
        Container(
          child: Center(
              child: Text(
            "Track sleep",
            style: TextStyle(
                fontFamily: 'Montserrat-Bold',
                fontSize: 20,
                color: Colors.black54),
          )),
        ),
      ],
    );
  }
}

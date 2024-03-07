import 'package:flutter/material.dart';
import 'package:health_app/pages/loginsignup/user_page.dart';

class NotificationPanel extends StatelessWidget {
  const NotificationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/Notification_panel.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text(
              'Stay Motivated With',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Montserrat-Bold',
                  color: Colors.white),
            ),
            const Text(
              'Fitness Notifications',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Montserrat-Bold',
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Notifications can help you close your rings,",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat-Regular',
                  color: Colors.white54),
            ),
            const Text(
              "cheer on you friends, and see what's new",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat-Regular',
                  color: Colors.white54),
            ),
            const Text(
              "with NEXA",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat-Regular',
                  color: Colors.white54),
            ),
            const SizedBox(
              height: 130,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const UserPage()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    height: 55,
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

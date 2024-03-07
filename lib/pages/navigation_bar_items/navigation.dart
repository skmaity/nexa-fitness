import 'package:flutter/material.dart';
import 'package:health_app/pages/navigation_bar_items/dashboard.dart';
import 'package:health_app/pages/navigation_bar_items/settings.dart';
import 'stats.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;
  List pages = [
    const DashBoard(),
    const Stats(),
    const Settings(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedFontSize: 10,
        unselectedFontSize: 8,
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Montserrat-Bold',
          fontSize: 12,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.primaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.interests), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      extendBody: true,
    );
  }
}

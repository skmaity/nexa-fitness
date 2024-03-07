import 'package:flutter/material.dart';
// import 'package:health_app/pages/navigation_bar_items/dash_items/sleep.dart';
import 'package:health_app/pages/navigation_bar_items/dash_items/steps.dart';

class DashMidSection extends StatefulWidget {
  const DashMidSection({super.key});

  @override
  State<DashMidSection> createState() => _DashMidSectionState();
}

class _DashMidSectionState extends State<DashMidSection> {
  @override
  Widget build(BuildContext context) {
    return const Steps();
  }
}

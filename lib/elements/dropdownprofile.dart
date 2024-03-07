import 'package:flutter/material.dart';

class DropDownProfile extends StatefulWidget {
  const DropDownProfile({super.key});

  @override
  State<DropDownProfile> createState() => DropDownProfileState();
}

class DropDownProfileState extends State<DropDownProfile> {
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String title;
  final List<String> items;

  Dropdown({this.title, this.items, Key key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with Dropdown.
class _DropdownState extends State<Dropdown> {
  String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DropdownButton<String>(
        hint: Text(dropdownValue),
        iconSize: 26,
        elevation: 40,
        isExpanded: true,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
      ),
    );
  }
}

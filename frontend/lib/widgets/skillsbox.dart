import 'package:flutter/material.dart';

class SkillBox extends StatefulWidget {
  final String title;

  const SkillBox({Key key, this.title}) : super(key: key);

  @override
  SkillBoxState createState() => SkillBoxState();
}

class SkillBoxState extends State<SkillBox> {
  TextEditingController _textController = TextEditingController();
  static List<String> mainDataList = [
    "Apple",
    "Apricot",
    "Banana",
    "Blackberry",
    "Coconut",
    "Date",
    "Fig",
    "Gooseberry",
    "Grapes",
    "Lemon",
    "Litchi",
    "Mango",
    "Orange",
    "Papaya",
    "Peach",
    "Pineapple",
    "Pomegranate",
    "Starfruit"
  ];

  // Copy Main List into New List.
  List<String> suggestedSkills = List.from(mainDataList);
  List<String> chosenSkills = [];

  onItemPressed(String skill) {
    setState(() {
      suggestedSkills.remove(skill);
      chosenSkills.add(skill);
    });
  }

  onItemDeleted(String skill) {
    setState(() {
      suggestedSkills.add(skill);
      chosenSkills.remove(skill);
    });
  }

  onItemChanged(String value) {
    setState(() {
      suggestedSkills = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Text(widget.title),
      TextField(
        controller: _textController,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
          hintText: 'Search Here...',
          fillColor: Colors.grey[100],
          filled: true,
        ),
        onChanged: onItemChanged,
      ),
      Wrap(
        direction: Axis.horizontal,
        spacing: 10.0,
        runSpacing: 5.0,
        children: chosenSkills.map((skill) {
          return Chip(
            label: Text(skill),
            deleteIcon: Icon(Icons.close),
            onDeleted: () => onItemDeleted(skill),
          );
        }).toList(),
      ),
      Divider(thickness: 1, color: Colors.grey),
      Wrap(
        direction: Axis.horizontal,
        spacing: 10.0,
        runSpacing: 5.0,
        children: suggestedSkills.map((skill) {
          return ActionChip(
            label: Text(skill),
            onPressed: () => onItemPressed(skill),
          );
        }).toList(),
      ),
    ]));
  }
}

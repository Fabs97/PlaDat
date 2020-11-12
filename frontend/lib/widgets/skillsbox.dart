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
      Row(
        children: [
          Text(widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.all(16.0),
          ),
        ],
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Search Here...',
                filled: true,
              ),
              onChanged: onItemChanged,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10.0,
                runSpacing: 5.0,
                children: chosenSkills.map((skill) {
                  return Chip(
                    backgroundColor: Colors.grey[600],
                    label: Text(
                      skill,
                      style: TextStyle(color: Colors.white),
                    ),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () => onItemDeleted(skill),
                  );
                }).toList(),
              ),
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
          ],
        ),
      )
    ]));
  }
}

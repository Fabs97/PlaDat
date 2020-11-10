import 'package:flutter/material.dart';

class OtherListSkills extends StatefulWidget {
  @override
  OtherListSkillsState createState() => OtherListSkillsState();
}

class OtherListSkillsState extends State<OtherListSkills> {
  TextEditingController _textController = TextEditingController();

  List<String> otherSkillsList = [];

  onItemPressed(String skill) {
    setState(() {
      otherSkillsList.add(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Other Skills"),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              suffixIcon: FloatingActionButton(
                onPressed: () => onItemPressed(_textController.text),
                child: Icon(Icons.add),
              ),
              hintText: 'Search Here...',
            ),
          ),
          Divider(thickness: 1, color: Colors.grey),
          Wrap(
            direction: Axis.horizontal,
            spacing: 10.0,
            runSpacing: 5.0,
            children: otherSkillsList.map((skill) {
              return Chip(
                label: Text(skill),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

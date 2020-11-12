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
          Row(
            children: [
              Text("Other Skills",
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
                    suffixIcon: IconButton(
                      onPressed: () => onItemPressed(_textController.text),
                      icon: Icon(Icons.add),
                    ),
                    hintText: 'Search Here...',
                    filled: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 5.0,
                    children: otherSkillsList.map((skill) {
                      return Chip(
                        backgroundColor: Colors.grey[600],
                        label: Text(
                          skill,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

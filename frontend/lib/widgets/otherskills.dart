import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';

class OtherSkills extends StatefulWidget {
  List<Skill> _otherSkills = [];

  OtherSkills({Key key}) : super(key: key);

  Object get otherSkills => null;

  @override
  OtherSkillsState createState() => OtherSkillsState();
}

class OtherSkillsState extends State<OtherSkills> {
  TextEditingController _textController = TextEditingController();

  onItemPressed(String skillName) {
    setState(() {
      widget._otherSkills.add(Skill(
        name: skillName,
        type: "OTHER",
      ));
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
                    children: widget._otherSkills.map((skill) {
                      return Chip(
                        backgroundColor: Colors.grey[600],
                        label: Text(
                          skill.name,
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

import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/utils/custom_theme.dart';

class OtherSkills extends StatefulWidget {
  List<Skill> _otherSkills = [];

  OtherSkills({Key key}) : super(key: key);

  Object get otherSkills => _otherSkills;

  @override
  OtherSkillsState createState() => OtherSkillsState();
}

class OtherSkillsState extends State<OtherSkills> {
  TextEditingController _textController = TextEditingController();

  onItemPressed(String skillName) {
    if (!widget._otherSkills.map((e) => e.name).contains(skillName)) {
      setState(() {
        widget._otherSkills.add(Skill(
          name: skillName,
          type: "OTHER",
        ));
        _textController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Row(
              children: [
                Text("Other Skills",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: CustomTheme().primaryColor),
                    textAlign: TextAlign.left),
                Padding(
                  padding: EdgeInsets.all(16.0),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [CustomTheme().boxShadow],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => onItemPressed(_textController.text),
                        icon: Icon(
                          Icons.add,
                          color: CustomTheme().primaryColor,
                        ),
                      ),
                      hintText: 'Insert Here...',
                      filled: true,
                      fillColor: CustomTheme().backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
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
                        label: Text(
                          skill.name,
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

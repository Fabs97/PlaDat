import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';

class SkillBox extends StatefulWidget {
  final String title;
  final String skillsType;
  List<Skill> _chosenSkills = [];

  SkillBox({@required this.skillsType, this.title, Key key}) : super(key: key);

  Object get chosenSkills => _chosenSkills;

  @override
  SkillBoxState createState() => SkillBoxState();
}

class SkillBoxState extends State<SkillBox> {
  TextEditingController _textController = TextEditingController();

  List<Skill> skills = [];
  List<Skill> suggestedSkills = [];

  _onItemPressed(Skill skill) {
    setState(() {
      suggestedSkills.remove(skill);
      widget._chosenSkills.add(skill);
    });
  }

  _onItemDeleted(Skill skill) {
    setState(() {
      suggestedSkills.add(skill);
      widget._chosenSkills.remove(skill);
    });
  }

  _onItemChanged(String value) {
    setState(() {
      //riempi suggested skills con le skill che hanno i name che combaciano
      suggestedSkills = skills.where((skill) {
        return skill.name.toLowerCase().contains(value.toLowerCase()) &&
            !widget._chosenSkills.contains(skill);
      }).toList();
    });
  }

  @override
  void initState() {
    APIService.route(ENDPOINTS.Skills, "/skills/type",
            urlArgs: widget.skillsType)
        .then((dynamicSkills) => setState(() {
              List<Skill> castedSkills = List<Skill>.from(dynamicSkills);
              skills = castedSkills;
              suggestedSkills =
                  skills?.sublist(0, skills.length < 4 ? skills.length : 4) ??
                      [];
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Row(
              children: [
                Text(widget.title,
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
                    fillColor: CustomTheme().backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(color: CustomTheme().backgroundColor),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: _onItemChanged,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 5.0,
                    children: widget._chosenSkills.map((skill) {
                      return Chip(
                        label: Text(
                          skill.name,
                        ),
                        deleteIcon: Icon(Icons.close),
                        onDeleted: () => _onItemDeleted(skill),
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
                      backgroundColor: themeData.accentColor,
                      labelStyle: TextStyle(
                        color: Color(0xffe23300),
                      ),
                      label: Text(skill.name),
                      onPressed: () => _onItemPressed(skill),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

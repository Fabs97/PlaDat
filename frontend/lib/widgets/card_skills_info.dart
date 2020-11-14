import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';

class CardSkillsChips extends StatelessWidget {
  final String title;
  final List<Skill> skills;

  const CardSkillsChips({Key key, this.title, this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: 10.0,
          runSpacing: 10.0,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}

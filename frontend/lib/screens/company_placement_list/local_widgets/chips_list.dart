import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';

class ListChips extends StatelessWidget {
  final List<Skill> skills;

  const ListChips({Key key, this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
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

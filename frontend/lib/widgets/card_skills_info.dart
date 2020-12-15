import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/utils/custom_theme.dart';

class CardSkillsChips extends StatelessWidget {
  final String title;
  final List<Skill> skills;

  const CardSkillsChips({Key key, this.title, this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: textTheme.headline6.copyWith(
              color: CustomTheme().primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: 8.0,
          runSpacing: 8.0,
          children: skills.map((skill) {
            return Chip(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
              label: Text(skill.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}

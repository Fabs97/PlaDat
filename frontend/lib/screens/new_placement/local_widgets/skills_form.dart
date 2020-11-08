import 'package:flutter/material.dart';
import 'package:frontend/widgets/otherskills.dart';
import 'package:frontend/widgets/skillsbox.dart';

class SkillsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListSearch(
          title: "Technical skills",
        ),
        ListSearch(
          title: "Soft skills",
        ),
        OtherListSkills(),
        RaisedButton(
            child: Text("Save"),
            onPressed: () {
              Navigator.of(context).popAndPushNamed("/home");
            }),
      ],
    );
  }
}

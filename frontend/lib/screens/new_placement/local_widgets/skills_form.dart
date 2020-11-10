import 'package:flutter/material.dart';
import 'package:frontend/widgets/otherskills.dart';
import 'package:frontend/widgets/skillsbox.dart';

class SkillsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          SkillBox(
            title: "Technical skills",
          ),
          SkillBox(
            title: "Soft skills",
          ),
          OtherListSkills(),
          RaisedButton(
              child: Text("Save"),
              onPressed: () {
                Navigator.of(context).popAndPushNamed("/home");
              }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SkillsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("Save"),
          onPressed: () {
            Navigator.of(context).popAndPushNamed("/home");
          }),
    );
  }
}

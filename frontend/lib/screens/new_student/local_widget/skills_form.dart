import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/otherskills.dart';
import 'package:frontend/widgets/skillsbox.dart';
import 'package:frontend/services/api_service.dart';
import 'package:provider/provider.dart';

class SkillsForm extends StatelessWidget {
  final SkillBox technicalSkillsBox = SkillBox(
    title: "Technical skills",
    skillsType: "TECH",
  );
  final SkillBox softSkillsBox = SkillBox(
    title: "Soft skills",
    skillsType: "SOFT",
  );
  final OtherSkills otherSkills = OtherSkills();

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            technicalSkillsBox,
            softSkillsBox,
            otherSkills,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.grey[600],
                child: Text(
                  "save",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _saveStudentToDB(context, student),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveStudentToDB(BuildContext context, Student student) async {
    student.skills = {
      "technicalSkills": technicalSkillsBox.chosenSkills,
      "softSkills": softSkillsBox.chosenSkills,
      "otherSkills": otherSkills.otherSkills,
    };

    Student newStudent = await APIService.route(
        ENDPOINTS.Student, "/student",
        body: student);
    print(newStudent);

    Navigator.of(context).popAndPushNamed("/home");
  }
}

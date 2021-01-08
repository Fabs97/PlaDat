import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/skillsbox.dart';
import 'package:frontend/services/api_service.dart';
import 'package:provider/provider.dart';

class SkillsForm extends StatelessWidget {
  final List<dynamic> skillsBoxes = [
    SkillBox(
      title: "Technical skills",
      skillsType: "TECH",
    ),
    SkillBox(
      title: "Soft skills",
      skillsType: "SOFT",
    )
  ];

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: size.height * .7,
              child: ListView.builder(
                itemCount: skillsBoxes.length,
                itemBuilder: (_, index) => skillsBoxes[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Publish your profile",
                    style: TextStyle(color: Colors.white),
                  ),
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
      "technicalSkills": skillsBoxes[0].chosenSkills,
      "softSkills": skillsBoxes[1].chosenSkills
    };

    student.userId = AuthService().loggedUser.id;

    dynamic response = await APIService.route(
      ENDPOINTS.Student,
      "/student",
      body: student,
    );

    String message;
    if (response is Student) {
      message = "Profile saved successfully";
      await AuthService()
          .setLoggedAccountInfo(AccountType.Student, response.id);
      Nav.currentState.popAndPushNamed("/student-home");
    } else if (response is String) {
      message = response;
    } else {
      message = "Something really wrong happened";
    }
    Fluttertoast.showToast(msg: message);
  }
}

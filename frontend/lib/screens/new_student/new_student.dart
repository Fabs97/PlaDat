import 'package:flutter/material.dart';
import 'package:frontend/screens/new_student/local_widget/skills_form.dart';
import 'package:frontend/screens/new_student/local_widget/student_form.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:provider/provider.dart';

class NewStudent extends StatefulWidget {
  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  bool _firstStep = true;
  //Student _newStudent = Student(name: "Bassam", surname: "Zabad");
  Student _newStudent = Student();

  void changeStep(bool step) {
    setState(() {
      _firstStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _newStudent,
        )
      ],
      child: Scaffold(
        appBar: CustomAppBar.createAppBar(context, "Student profile"),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              _firstStep ? StudentForm(changeStep: changeStep) :SkillsForm(),
            
            ],
          ),
        ),
      ),
    );
  }
}

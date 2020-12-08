import 'package:flutter/material.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/new_student/local_widget/experience_card.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:provider/provider.dart';

class ExperiencesForm extends StatefulWidget {
  final bool isEducationsForm;
  const ExperiencesForm({
    Key key,
    @required this.isEducationsForm,
  }) : super(key: key);

  @override
  ExperiencesFormState createState() => ExperiencesFormState();
}

class ExperiencesFormState extends State<ExperiencesForm> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _experiences = [];

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    final formStepper = Provider.of<FormStepper>(context);
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          children: [
            _createAddExperienceRow(),
            ListView.builder(
              itemBuilder: (_, index) {
                return ExperienceCard(
                  experience: _experiences[index],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.grey[600],
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (widget.isEducationsForm) {
                      student.educations = _experiences;
                    } else {
                      student.works = _experiences;
                    }
                    setState(() {
                      formStepper.goToNextFormStep();
                    });
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _createAddExperienceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          widget.isEducationsForm ? "Education" : "Work Experience",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // TODO: onPressed function addEducation
          },
        )
      ],
    );
  }
}

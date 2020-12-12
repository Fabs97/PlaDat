import 'package:flutter/material.dart';
import 'package:frontend/models/degree.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/new_student/local_widget/experience_card.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:frontend/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:provider/provider.dart';

class EducationExperiencesForm extends StatefulWidget {
  const EducationExperiencesForm({
    Key key,
  }) : super(key: key);

  @override
  EducationExperiencesFormState createState() =>
      EducationExperiencesFormState();
}

class EducationExperiencesFormState extends State<EducationExperiencesForm> {
  final _formKey = GlobalKey<FormState>();
  bool _creatingExperience = false;

  List<dynamic> _experiences = [];

  EducationExperience _newExperience = EducationExperience();

  List<Institution> _institutions = [];
  List<Major> _majors = [];
  List<Degree> _degrees = [];

  @override
  void initState() {
    APIService.route(ENDPOINTS.Majors, "/majors").then((majors) {
      setState(() {
        _majors = majors.cast<Major>();
      });
    }).catchError((err) {
      print(err);
    });
    APIService.route(ENDPOINTS.Institutions, "/institutions")
        .then((institutions) {
      _institutions = institutions.cast<Institution>();
    }).catchError((err) {
      print(err);
    });
    APIService.route(ENDPOINTS.Degree, "/degrees").then((degrees) {
      _degrees = degrees.cast<Degree>();
    }).catchError((err) {
      print(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final student = Provider.of<Student>(context);
    final formStepper = Provider.of<FormStepper>(context);
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _createAddExperienceRow(),
          _creatingExperience ? _createExperienceForm(student) : Container(),
          SizedBox.shrink(
            // height: size.height * (_creatingExperience ? .5 : .7),
            child: _experiences.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (_, index) {
                      return ExperienceCard(
                        experience: _experiences[index],
                      );
                    },
                  )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              color: Colors.grey[600],
              onPressed: () {
                if (!_creatingExperience ||
                    (_creatingExperience && _formKey.currentState.validate())) {
                  student.educations = _experiences.cast<EducationExperience>();
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
      ),
    );
  }

  _toggleExperienceCreationForm() {
    setState(() {
      _creatingExperience = !_creatingExperience;
    });
  }

  _createAddExperienceRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Education",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Spacer(),
          IconButton(
            icon: _creatingExperience ? Icon(Icons.close) : Icon(Icons.add),
            onPressed: _toggleExperienceCreationForm,
          )
        ],
      ),
    );
  }

  _createExperienceForm(Student student) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: _createEducationForm(student),
          ),
        ),
      ),
    );
  }

  _createEducationForm(Student student) {
    final formatter = DateFormat('dd/MMM/yyyy');
    return [
      DropdownButtonFormField<Institution>(
        items: (_institutions ?? [])
            .map((institution) => DropdownMenuItem<Institution>(
                  value: institution,
                  child: Text(institution.name),
                ))
            .toList(),
        hint: Text("Institution"),
        onChanged: (value) {
          setState(() {
            _newExperience.institution = value;
          });
        },
        validator: (value) {
          if (value == null) return "Please choose an institution";
          return null;
        },
        value: _newExperience.institution,
      ),
      DropdownButtonFormField<Degree>(
        items: (_degrees ?? [])
            .map((degree) => DropdownMenuItem<Degree>(
                  value: degree,
                  child: Text(degree.name),
                ))
            .toList(),
        hint: Text("Degree"),
        onChanged: (value) {
          setState(() {
            _newExperience.degree = value;
          });
        },
        validator: (value) {
          if (value == null) return "Please choose a degree";
          return null;
        },
        value: _newExperience.degree,
      ),
      DropdownButtonFormField<Major>(
        items: (_majors ?? [])
            .map((major) => DropdownMenuItem<Major>(
                  value: major,
                  child: Text(major.name),
                ))
            .toList(),
        hint: Text("Major"),
        onChanged: (value) {
          setState(() {
            _newExperience.major = value;
          });
        },
        validator: (value) {
          if (value == null) return "Please choose a major";
          return null;
        },
        value: _newExperience.major,
      ),
      TextFormField(
        onTap: () => _openDatePicker(),
        decoration: InputDecoration(
          hintText: _newExperience.startPeriod != null &&
                  _newExperience.endPeriod != null
              ? "${formatter.format(_newExperience.startPeriod)} - ${formatter.format(_newExperience.endPeriod)} "
              : "Working period",
        ),
        readOnly: true,
      ),
      TextFormField(
        decoration: const InputDecoration(
          hintText: "Try to be as descriptive as possible",
          labelText: "Describe your work experience",
          filled: true,
        ),
        initialValue: _newExperience.description ?? "",
        onChanged: (value) {
          setState(() {
            _newExperience.description = value;
          });
        },
        maxLines: 4,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                //TODO: implement save button onPressed
              },
            ),
          ],
        ),
      ),
    ];
  }

  void _openDatePicker() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: _newExperience.startPeriod ?? DateTime.now(),
      initialLastDate: _newExperience.endPeriod ??
          (new DateTime.now()).add(new Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: (DateTime.now()).add(Duration(days: 365 * 100)),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        // picked is always ordered with the smaller one coming at index 0
        _newExperience.startPeriod = picked[0];
        _newExperience.endPeriod = picked[1];
      });
    }
  }
}

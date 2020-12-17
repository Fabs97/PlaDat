import 'package:flutter/material.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/models/work_experience.dart';
import 'package:frontend/screens/new_student/local_widget/experience_card.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WorkExperiencesForm extends StatefulWidget {
  const WorkExperiencesForm({
    Key key,
  }) : super(key: key);

  @override
  WorkExperiencesFormState createState() => WorkExperiencesFormState();
}

class WorkExperiencesFormState extends State<WorkExperiencesForm> {
  final _formKey = GlobalKey<FormState>();
  bool _creatingExperience = false;

  List<dynamic> _experiences = [];

  WorkExperience _newExperience = WorkExperience();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final student = Provider.of<Student>(context);
    final formStepper = Provider.of<FormStepper>(context);
    final List<WorkExperience> works = [...student.works ?? [], ..._experiences]
        .toSet()
        .toList()
        .cast<WorkExperience>();
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: _createAddExperienceRow(),
            flex: 1,
          ),
          _creatingExperience
              ? Flexible(
                  child: _createExperienceForm(student),
                  flex: 3,
                )
              : Container(),
          Flexible(
            flex: _creatingExperience ? 1 : 4,
            child: works.isNotEmpty
                ? ListView.builder(
                    itemCount: works.length,
                    itemBuilder: (_, index) {
                      return ExperienceCard(
                        experience: works[index],
                      );
                    },
                  )
                : Container(),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              color: Colors.grey[600],
              onPressed: () {
                if (!_creatingExperience ||
                    (_creatingExperience && _formKey.currentState.validate())) {
                  student.works = works.cast<WorkExperience>();
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
            "Work Experience",
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
          boxShadow: [CustomTheme().boxShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: _createWorkForm(student),
          ),
        ),
      ),
    );
  }

  _createWorkForm(Student student) {
    final formatter = DateFormat('dd/MMM/yyyy');
    return [
      TextFormField(
        decoration: const InputDecoration(
          hintText: 'Position',
        ),
        initialValue: _newExperience.position ?? "",
        onChanged: (value) {
          setState(() {
            _newExperience.position = value;
          });
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the position of your experience';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          hintText: 'Company Name',
        ),
        initialValue: _newExperience.companyName ?? "",
        onChanged: (value) {
          setState(() {
            _newExperience.companyName = value;
          });
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the company of your experience';
          }
          return null;
        },
      ),
      TextFormField(
        onTap: () => _openDatePicker(),
        decoration: InputDecoration(
          hintText: _newExperience.startPeriod != null &&
                  _newExperience.endPeriod != null
              ? "${formatter.format(_newExperience.startPeriod)} - ${formatter.format(_newExperience.endPeriod)} "
              : "Period of work",
        ),
        readOnly: true,
        validator: (_) {
          if (_newExperience.startPeriod.isAfter(DateTime.now()))
            return "Starting date can't be in the future";
          return null;
        },
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
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
            child: Text("Save"),
            onPressed: () {
              setState(() {
                _experiences.add(_newExperience);
                student.works = [
                  ...student.works ?? [],
                  ..._experiences,
                ];
                _newExperience = new WorkExperience();
                _creatingExperience = false;
              });
            },
          ),
        ],
      ),
    ];
  }

  void _openDatePicker() async {
    final DateTimeRange range = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: _newExperience.startPeriod ?? DateTime.now(),
        end: _newExperience.endPeriod ??
          (new DateTime.now()).add(new Duration(days: 7)),
      ),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
      lastDate: (DateTime.now()).add(Duration(days: 365 * 100)),
    );
    if (range != null) {
      setState(() {
        // picked is always ordered with the smaller one coming at index 0
        _newExperience.startPeriod = range.start;
        _newExperience.endPeriod = range.end;
      });
    }
  }
}

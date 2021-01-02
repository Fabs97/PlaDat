import 'package:flutter/material.dart';
import 'package:frontend/models/degree.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/new_student/local_widget/experience_card.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:intl/intl.dart';
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
    final themeData = Theme.of(context);
    final student = Provider.of<Student>(context);
    final formStepper = Provider.of<FormStepper>(context);
    final List<EducationExperience> educations = [
      ...student.educations ?? [],
      ..._experiences
    ].toSet().toList().cast<EducationExperience>();
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
                  flex: 4,
                )
              : Container(),
          Flexible(
            flex: _creatingExperience ? 1 : 4,
            child: educations.isNotEmpty
                ? ListView.builder(
                    itemCount: educations.length,
                    itemBuilder: (_, index) {
                      return ExperienceCard(
                        experience: educations[index],
                      );
                    },
                  )
                : Container(),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: size.width * .9,
              child: RaisedButton(
                onPressed: () {
                  //need to check the validation also here
                  if (!_creatingExperience ||
                      (_creatingExperience &&
                          _formKey.currentState.validate())) {
                    student.educations = educations.cast<EducationExperience>();
                    setState(() {
                      formStepper.goToNextFormStep();
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Continue",
                    style: themeData.textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
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
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: CustomTheme().primaryColor),
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
    return SingleChildScrollView(
      child: Form(
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
              children: _createEducationForm(student),
            ),
          ),
        ),
      ),
    );
  }

  _createEducationForm(Student student) {
    final formatter = DateFormat('dd/MMM/yyyy');
    return [
      DropdownButtonFormField<Institution>(
        iconEnabledColor: CustomTheme().primaryColor,
        items: (_institutions ?? [])
            .map((institution) => DropdownMenuItem<Institution>(
                  value: institution,
                  child: Text(institution.name),
                ))
            .toList(),
        hint: Text(
          "Institution",
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 16.0,
                color: CustomTheme().textColor,
              ),
        ),
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
        iconEnabledColor: CustomTheme().primaryColor,
        items: (_degrees ?? [])
            .map((degree) => DropdownMenuItem<Degree>(
                  value: degree,
                  child: Text(degree.name),
                ))
            .toList(),
        hint: Text(
          "Degree",
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 16.0,
                color: CustomTheme().textColor,
              ),
        ),
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
        iconEnabledColor: CustomTheme().primaryColor,
        items: (_majors ?? [])
            .map((major) => DropdownMenuItem<Major>(
                  value: major,
                  child: Text(major.name),
                ))
            .toList(),
        hint: Text(
          "Major",
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 16.0,
                color: CustomTheme().textColor,
              ),
        ),
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
              ? "${formatter.format(_newExperience.startPeriod)} - ${formatter.format(_newExperience.endPeriod)}"
              : "Period of study (mm/yyyy - mm-yyyy)",
        ),
        readOnly: true,
        validator: (_) {
          if (_newExperience.startPeriod.isAfter(DateTime.now()))
            return "Starting date can't be in the future";
          return null;
        },
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(
              'Describe your academic activity',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontSize: 16,
                    color: CustomTheme().textColor,
                  ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
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
            child: Text("Save",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: CustomTheme().accentTextColor,
                    )),
            onPressed: () {
              setState(() {
                _experiences.add(_newExperience);
                student.educations = [
                  ...student.educations ?? [],
                  ..._experiences,
                ];
                _newExperience = new EducationExperience();
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

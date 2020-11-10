import 'dart:ui';

import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/new_placement/local_widgets/dropdown.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/api_services/majors_api_service.dart';
import 'package:intl/intl.dart';

class PlacementForm extends StatefulWidget {
  final Function(bool) changeStep;

  const PlacementForm({Key key, this.changeStep}) : super(key: key);
  @override
  _PlacementFormState createState() => _PlacementFormState();
}

class _PlacementFormState extends State<PlacementForm> {
  final _formKey = GlobalKey<FormState>();

  DateTimeRange dateTimeRange;
  List<String> majorsList = [];
  List<String> institutionsList = [];

  @override
  void initState() {
    APIService.route(ENDPOINTS.Majors, "/majors").then((majors) {
      setState(() {
        majorsList = majors
            .map((major) {
              return major.name;
            })
            .toList()
            .cast<String>();
      });
    }).catchError((err) {
      print(err);
    });
    APIService.route(ENDPOINTS.Institutions, "/institutions")
        .then((institutions) {
      institutionsList = institutions
          .map((institution) {
            return institution.name;
          })
          .toList()
          .cast<String>();
    }).catchError((err) {
      print(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Container(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _createPlacementField(),
                        _createWorkingHoursField(),
                        _createWorkingPeriodField(),
                        _createSalaryField(),
                        _createDescriptionField(),
                        Dropdown(
                          title: 'Preferred Institutions',
                          items: institutionsList,
                        ),
                        Dropdown(
                          title: 'Preferred Majors',
                          items: majorsList,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    color: Colors.grey[600],
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      widget.changeStep(false); //TODO rimmettere nell'if
                      if (_formKey.currentState.validate()) {
                        // Process data.

                      }
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createPlacementField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Placement role',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a placement role';
        }
        return null;
      },
    );
  }

  Widget _createWorkingHoursField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Working hours per week',
        hintText: 'Insert only digits 0-9',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value.isEmpty) {
          return 'Specify the amout of working hours per week';
        } else if (int.parse(value) >= 40) {
          return 'Too many working hours';
        }
        return null;
      },
    );
  }

  Widget _createWorkingPeriodField() {
    return SafeArea(
      child: DateRangeField(
        context: context,
        decoration: InputDecoration(
          labelText: "Date Range",
          prefixIcon: Icon(Icons.date_range),
          hintText: "Please select a start and end date",
          // border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
        ),
        initialValue: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        ),
        dateFormat: DateFormat('dd/MM/yyyy'),
        validator: (value) {
          if (value.start.isBefore(DateTime.now())) {
            return "Please enter a valid date";
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            print(dateTimeRange);
            dateTimeRange = value;
            print(dateTimeRange);
          });
        },
      ),
    );
  }

  Widget _createSalaryField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Salary per month',
        hintText: 'Insert only digits 0-9',
        prefixText: "€ ",
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a salary';
        }
        return null;
      },
    );
  }

  Widget _createDescriptionField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Try to be as descriptive as possible",
        labelText: "Describe the role's activity",
        filled: true,
      ),
      maxLines: 4,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}

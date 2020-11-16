import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/screens/new_placement/local_widgets/dropdown.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/api_services/majors_api_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class PlacementForm extends StatefulWidget {
  final Function(bool) changeStep;

  const PlacementForm({Key key, this.changeStep}) : super(key: key);
  @override
  _PlacementFormState createState() => _PlacementFormState();
}

class _PlacementFormState extends State<PlacementForm> {
  final _formKey = GlobalKey<FormState>();

  DateTimeRange dateTimeRange;
  Dropdown majorsWidget = Dropdown(
    title: 'Preferred Majors',
  );
  Dropdown institutionsWidget = Dropdown(
    title: 'Preferred Institutions',
  );

  @override
  void initState() {
    APIService.route(ENDPOINTS.Majors, "/majors").then((majors) {
      setState(() {
        majorsWidget.items = majors;
      });
    }).catchError((err) {
      print(err);
    });
    APIService.route(ENDPOINTS.Institutions, "/institutions")
        .then((institutions) {
      institutionsWidget.items = institutions;
    }).catchError((err) {
      print(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placement = Provider.of<Placement>(context);
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
                        _createPlacementField(placement),
                        _createWorkingHoursField(placement),
                        _createWorkingPeriodField(placement),
                        _createSalaryField(placement),
                        _createDescriptionField(placement),
                        majorsWidget ?? Container(),
                        institutionsWidget ?? Container(),
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
                      if (_formKey.currentState.validate()) {
                        placement.majors = majorsWidget.itemsChosen;
                        placement.institutions = institutionsWidget.itemsChosen;
                        widget.changeStep(false);
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

  Widget _createPlacementField(Placement placement) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Placement role',
      ),
      initialValue: placement.position ?? '',
      onChanged: (value) {
        setState(() {
          placement.position = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a placement role';
        }
        return null;
      },
    );
  }

  Widget _createWorkingHoursField(Placement placement) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Working hours per week',
        hintText: 'Insert only digits 0-9',
      ),
      initialValue: placement.workingHours?.toString(),
      onChanged: (value) {
        setState(() {
          placement.workingHours = value != null ? int.parse(value) : "";
        });
      },
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

  void _openDatePicker(Placement placement) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: placement.startPeriod ?? DateTime.now(),
      initialLastDate: placement.endPeriod ??
          (new DateTime.now()).add(new Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: (DateTime.now()).add(Duration(days: 365 * 100)),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        // picked is always ordered with the smaller one coming at index 0
        placement.startPeriod = picked[0];
        placement.endPeriod = picked[1];
      });
    }
  }

  Widget _createWorkingPeriodField(Placement placement) {
    final formatter = DateFormat('dd/MMM/yyyy');
    return TextFormField(
      onTap: () => _openDatePicker(placement),
      decoration: InputDecoration(
        hintText: placement.startPeriod != null && placement.endPeriod != null
            ? "${formatter.format(placement.startPeriod)} - ${formatter.format(placement.endPeriod)} "
            : "Working period",
      ),
      readOnly: true,
    );
  }

  Widget _createSalaryField(Placement placement) {
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
      initialValue: placement.salary?.toString(),
      onChanged: (value) {
        setState(() {
          placement.salary = value != null ? int.parse(value) : "";
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a salary';
        }
        return null;
      },
    );
  }

  Widget _createDescriptionField(Placement placement) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Try to be as descriptive as possible",
        labelText: "Describe the role's activity",
        filled: true,
      ),
      initialValue: placement.description ?? '',
      onChanged: (value) {
        setState(() {
          placement.description = value;
        });
      },
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

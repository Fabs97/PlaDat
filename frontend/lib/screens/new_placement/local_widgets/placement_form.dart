import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/place.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/screens/new_placement/local_widgets/dropdown.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/address_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  TextEditingController _controller = new TextEditingController();
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

    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placement = Provider.of<Placement>(context);
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
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
                    boxShadow: [CustomTheme().boxShadow],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _createPlacementField(placement),
                          _createTypeOfEmploymentField(placement),
                          _createWorkingPeriodField(placement, context),
                          _createSalaryField(placement),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Describe the role's activity",
                                  style: themeData.textTheme.subtitle1.copyWith(
                                    fontSize: 16,
                                    color: CustomTheme().textColor,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          _createDescriptionField(placement),
                          majorsWidget ?? Container(),
                          institutionsWidget ?? Container(),
                          _cretaeautocompleteField(placement),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        placement.majors = majorsWidget.itemsChosen;
                        placement.institutions = institutionsWidget.itemsChosen;
                        widget.changeStep(false);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Continue',
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
        hintText: 'Position',
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
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

  Widget _createTypeOfEmploymentField(Placement placement) {
    return DropdownButtonFormField<EmploymentType>(
      decoration: const InputDecoration(
        hintText: "Type of contract",
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black87,
        size: 25.0,
      ),
      validator: (value) {
        if (value == null) return "Please choose an employment type";
        return null;
      },
      onChanged: (employmentType) => setState(() {
        placement.employmentType = employmentType;
      }),
      items: [
        _createDropdownButtonEmploymentTypeItem(EmploymentType.FULLTIME),
        _createDropdownButtonEmploymentTypeItem(EmploymentType.PARTTIME),
        _createDropdownButtonEmploymentTypeItem(EmploymentType.CONTRACT),
        _createDropdownButtonEmploymentTypeItem(EmploymentType.INTERNSHIP),
      ],
    );
  }

  Widget _createDropdownButtonEmploymentTypeItem(EmploymentType type) {
    return DropdownMenuItem(
      child: Text(type.niceString),
      value: type,
    );
  }

  void _openDatePicker(Placement placement) async {
    final DateTimeRange range = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: placement.startPeriod ?? DateTime.now(),
        end: placement.endPeriod ??
            (new DateTime.now()).add(new Duration(days: 7)),
      ),
      firstDate: DateTime.now(),
      lastDate: (DateTime.now()).add(Duration(days: 365 * 100)),
    );
    if (range != null) {
      setState(() {
        // picked is always ordered with the smaller one coming at index 0
        placement.startPeriod = range.start;
        placement.endPeriod = range.end;
      });
    }
  }

  Widget _createWorkingPeriodField(Placement placement, BuildContext context) {
    final formatter = DateFormat('dd/MMM/yyyy');
    return Theme(
      data: Theme.of(context).copyWith(
          accentColor: Colors.cyan[600], primaryColor: Colors.lightBlue[800]),
      child: TextFormField(
        onTap: () => _openDatePicker(placement),
        decoration: InputDecoration(
          hintText: placement.startPeriod != null && placement.endPeriod != null
              ? "${formatter.format(placement.startPeriod)} - ${formatter.format(placement.endPeriod)} "
              : "Working period",
          hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
        ),
        readOnly: true,
      ),
    );
  }

  Widget _createSalaryField(Placement placement) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Yearly salary',
        hintText: 'Insert only digits 0-9',
        prefixText: "£ ",
        labelStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
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
        border: OutlineInputBorder(),
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

  Widget _cretaeautocompleteField(Placement placement) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Address',
      ),
      //initialValue: _controller.text ?? ' ',
      onTap: () async {
        final Place result = await showSearch(
          context: context,
          delegate: AddressSearch(),
        );

        // This will change the text displayed in the TextField
        if (result != null) {
          setState(() {
            _controller.text = result.description;
            List<String> splits = result.description.split(",");
            result.country = splits[splits.length - 1];
            result.city = splits[splits.length - 2];
            placement.location = result;
          });
        }
      },

      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your address';
        }
        return null;
      },
    );
  }
}

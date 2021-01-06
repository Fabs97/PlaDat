import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/domainofactivity.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/address_search.dart';
import 'package:frontend/models/place.dart';
import 'package:provider/provider.dart';

class EmployerForm extends StatefulWidget {
  const EmployerForm({Key key}) : super(key: key);
  @override
  _EmployerFormState createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  List<Domainofactivity> _domains;
  Domainofactivity _domain;

  @override
  void initState() {
    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    APIService.route(ENDPOINTS.Domainofactivities, "/domainOfActivity")
        .then((domainofactivities) {
      setState(() {
        _domains = domainofactivities?.cast<Domainofactivity>();
        _domain = _domains[0] ?? null;
      });
    }).catchError((err) {
      print(err);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employer = Provider.of<Employer>(context);
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
                    boxShadow: [CustomTheme().boxShadow],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _createnameField(employer),
                        _cretaeautocompleteField(employer),
                        _createDropdown(),
                        _createDescriptionField(employer),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _saveEmployerToDB(context, employer);
                        });
                      }
                    },
                    child: Text(
                      'Save company information',
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

  Widget _createnameField(Employer employer) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Company name',
      ),
      initialValue: employer.name ?? '',
      onChanged: (value) {
        setState(() {
          employer.name = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a company name';
        }
        return null;
      },
    );
  }

  Widget _createDescriptionField(Employer employer) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Describe the company",
        labelText: "Tell about company",
        filled: true,
      ),
      initialValue: employer.description ?? '',
      onChanged: (value) {
        setState(() {
          employer.description = value;
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

  Widget _cretaeautocompleteField(Employer employer) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Location',
      ),
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
            employer.location = result;
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

  _createDropdown() {
    final customTheme = CustomTheme();
    return _domains == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<Domainofactivity>(
                disabledHint: Text("No domains found!"),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: customTheme.primaryColor,
                ),
                iconEnabledColor: customTheme.primaryColor,
                iconDisabledColor: customTheme.secondaryColor,
                value: _domain,
                items: _domains?.map((domain) {
                      return DropdownMenuItem<Domainofactivity>(
                        value: domain,
                        child: Text(
                          '${domain.name}',
                          style: TextStyle(
                            color: customTheme.primaryColor,
                          ),
                        ),
                      );
                    })?.toList() ??
                    [],
                onChanged: onChangeDropdownItem,
              ),
            ),
          );
  }

  onChangeDropdownItem(Domainofactivity selectedDomain) {
    if (selectedDomain == null) return;
    setState(() {
      _domain = selectedDomain;
    });
  }

  void _saveEmployerToDB(BuildContext context, Employer employer) async {
    employer.domainOfActivityId = _domain.id;
    dynamic response = await APIService.route(
      ENDPOINTS.Employers,
      "/employer",
      body: employer,
    );

    String message;
    if (response is Employer) {
      message = "Profile saved successfully";
      await AuthService()
          .setLoggedAccountInfo(AccountType.Employer, response.id);
      Nav.currentState.popAndPushNamed("/employer-home");
    } else if (response is String) {
      message = response;
    } else {
      message = "Something really wrong happened";
    }
    Fluttertoast.showToast(msg: message);
  }
}

import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/address_search.dart';
import 'package:frontend/models/place.dart';
import 'package:intl/intl.dart';
import 'package:frontend/screens/new_student/new_student.dart';
import 'package:provider/provider.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key key}) : super(key: key);
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    final formStepper = Provider.of<FormStepper>(context);
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * .855,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          "Basic information",
                          style: themeData.textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: CustomTheme().primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Form(
                    key: _formKey,
                    child: SafeArea(
                      child: Column(
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
                                vertical: 10.0,
                              ),
                              child: Column(
                                children: [
                                  _createnameField(student),
                                  _createsurnameField(student),
                                  _createemailField(student),
                                  _createphoneField(student),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Tell us about yourself',
                                          style: themeData.textTheme.subtitle1
                                              .copyWith(
                                            fontSize: 16,
                                            color: CustomTheme().textColor,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  _createDescriptionField(student),
                                  _cretaeautocompleteField(student),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: size.width * .9,
              child: Container(
                child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    // TODO: delete setState outside
                    setState(() {
                      formStepper.goToNextFormStep();
                    });
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        formStepper.goToNextFormStep();
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createnameField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name',
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
      ),
      initialValue: student.name ?? '',
      onChanged: (value) {
        setState(() {
          student.name = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a student name';
        }
        return null;
      },
    );
  }

  Widget _createsurnameField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Surname',
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
      ),
      initialValue: student.surname ?? '',
      onChanged: (value) {
        setState(() {
          student.surname = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a student surname';
        }
        return null;
      },
    );
  }

  Widget _createemailField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
        suffixText: 'student@school.com',
        suffixStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 16,
            color: Color(0xff4c4c4c)),
      ),
      initialValue: student.email ?? '',
      onChanged: (value) {
        setState(() {
          student.email = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a student email';
        } else if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _createDescriptionField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      initialValue: student.description ?? '',
      onChanged: (value) {
        setState(() {
          student.description = value;
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

  Widget _createphoneField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Phone number',
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      initialValue: student.phone ?? '',
      onChanged: (value) {
        setState(() {
          student.phone = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        }
        return null;
      },
    );
  }

  Widget _cretaeautocompleteField(Student student) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Address',
        hintStyle: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)),
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
            student.location = result;
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

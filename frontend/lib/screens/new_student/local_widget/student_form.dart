import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/student.dart';
import 'package:provider/provider.dart';


class StudentForm extends StatefulWidget {
  final Function(bool) changeStep;

  const StudentForm({Key key, this.changeStep}) : super(key: key);
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();

  
  
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
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
                        _createnameField(student),
                        _createsurnameField(student),
                        _createemailField(student),
                        _createphoneField(student),
                        _createDescriptionField(student),
                        
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

  Widget _createnameField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name',
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
        hintText: 'student@school.com',
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
        }
        else if(!EmailValidator.validate(value)){
           return 'Please enter a valid email';
        }
        return null;
      },
    );
  }



  Widget _createDescriptionField(Student student) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Try to be as descriptive as possible",
        labelText: "Tell about yourself",
        filled: true,
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




}

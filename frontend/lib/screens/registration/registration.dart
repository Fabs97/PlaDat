import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

enum AccountType { Student, Employer }

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _secondPassword = "";
  AccountType _accountType = AccountType.Student;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "Register to PlaDat"),
      drawer: CustomDrawer.createDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width * .8,
                      height: screenSize.height * .45,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 5.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _createEmailInputField(),
                              _createPasswordInputField(),
                              _createSecondPasswordInputField(),
                              _createInfoBox(screenSize),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
                        child: Text(
                          "Account type",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    _createAccountTypeRadios(screenSize),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * .8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: RaisedButton(
                  child: Text("Register"),
                  onPressed: _registerToPlaDat(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _createEmailInputField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "julian@bass.test",
      ),
      initialValue: _email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) {
        if (!EmailValidator.validate(email))
          return "Please inser a valid email";
        return null;
      },
      onChanged: (email) {
        setState(() {
          _email = email;
        });
      },
    );
  }

  _createPasswordInputField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
      ),
      initialValue: _password,
      validator: (value) {
        if (!RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$').hasMatch(value)) {
          return "Please input a correct password";
        }
        return null;
      },
      onChanged: (password) => setState(() => _password = password),
    );
  }

  _createSecondPasswordInputField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
      ),
      initialValue: _secondPassword,
      validator: (value) {
        if (!RegExp(_password).hasMatch(value)) {
          return "The password doesn't match";
        }
        return null;
      },
      onChanged: (password) => setState(() => _secondPassword = password),
    );
  }

  _createInfoBox(Size screenSize) {
    return Text(
      "Your password should be at least 8 characters and shall include at least a digital and a capital letter",
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  _createAccountTypeRadios(Size screenSize) {
    return SizedBox(
      width: screenSize.width * .8,
      height: screenSize.height * .18,
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
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              RadioListTile<AccountType>(
                title: const Text("Employer"),
                value: AccountType.Employer,
                groupValue: _accountType,
                onChanged: (accountType) =>
                    setState(() => _accountType = accountType),
              ),
              RadioListTile<AccountType>(
                title: const Text("Student"),
                value: AccountType.Student,
                groupValue: _accountType,
                onChanged: (accountType) =>
                    setState(() => _accountType = accountType),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _registerToPlaDat() {
    //TODO register to PlaDat
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _obscurePassword = true;
  String _secondPassword = "";
  bool _obscureSecondPassword = true;
  AccountType _accountType = AccountType.Student;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register to PlaDat"),
        centerTitle: true,
        leading: Container(),
      ),
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
                      width: screenSize.width * .855,
                      height: screenSize.height * .368,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [CustomTheme().boxShadow],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _createEmailInputField(),
                              _createPasswordInputField(),
                              _createSecondPasswordInputField(),
                              _createInfoBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * .855,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(21.0, 15.0, 0.0, 15.0),
                        child: Text(
                          "Account type",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18.0,
                                color: CustomTheme().primaryColor,
                              ),
                        ),
                      ),
                    ),
                    _createAccountTypeRadios(screenSize, themeData),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * .855,
              child: Container(
                child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Register",
                      style: themeData.textTheme.subtitle1.copyWith(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  onPressed: _registerToPlaDat,
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
        contentPadding: EdgeInsets.all(0.0),
      ),
      initialValue: _email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) {
        if (!EmailValidator.validate(email)) {
          return "Please inser a valid email";
        }
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
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: "Password",
        contentPadding: EdgeInsets.all(0.0),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: CustomTheme().primaryColor,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
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
      obscureText: _obscureSecondPassword,
      decoration: InputDecoration(
        labelText: "Password",
        contentPadding: EdgeInsets.all(0.0),
        suffixIcon: IconButton(
          icon: Icon(
              _obscureSecondPassword ? Icons.visibility_off : Icons.visibility),
          color: CustomTheme().primaryColor,
          onPressed: () {
            setState(() {
              _obscureSecondPassword = !_obscureSecondPassword;
            });
          },
        ),
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

  _createInfoBox() {
    return Text(
      "Your password should be at least 8 characters and shall include at least a digital and a capital letter",
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  _createAccountTypeRadios(Size screenSize, ThemeData themeData) {
    return SizedBox(
      width: screenSize.width * .855,
      height: screenSize.height * .13,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [CustomTheme().boxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            RadioListTile<AccountType>(
              activeColor: CustomTheme().secondaryColor,
              title: Text(
                "Employer",
                style: themeData.textTheme.subtitle1,
              ),
              dense: true,
              value: AccountType.Employer,
              groupValue: _accountType,
              onChanged: (accountType) =>
                  setState(() => _accountType = accountType),
            ),
            RadioListTile<AccountType>(
              activeColor: CustomTheme().secondaryColor,
              title: Text(
                "Student",
                style: themeData.textTheme.subtitle1,
              ),
              dense: true,
              value: AccountType.Student,
              groupValue: _accountType,
              onChanged: (accountType) =>
                  setState(() => _accountType = accountType),
            ),
          ],
        ),
      ),
    );
  }

  _registerToPlaDat() {
    if (_formKey.currentState.validate()) {
      APIService.route(
        ENDPOINTS.Registration,
        "/registration",
        body: User(
          email: _email,
          password: _password,
          type: _accountType,
        ),
      ).then((response) {
        String message;
        Color toastColor;
        if (response is User) {
          message = "User correctly registered";
          toastColor = Colors.blue[700];
          Nav.currentState.pop();
        } else {
          message = response;
          toastColor = Colors.redAccent;
        }
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }).catchError((error) {
        print(error);
        Fluttertoast.showToast(msg: error);
      });
    }
  }
}

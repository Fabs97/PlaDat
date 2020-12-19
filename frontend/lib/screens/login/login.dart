import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/api_services/login_api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/appbar.dart';

class Login extends StatefulWidget {
  bool isAfterAuthError;
  Login({Key key, this.isAfterAuthError}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User _user = User();
  bool _obscurePassword = true;
  bool _hasLoginErrors = false;

  @override
  void initState() {
    if (widget.isAfterAuthError) {
      Fluttertoast.showToast(msg: "There was authenticating you, please login again");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "Login to PlaDat"),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _createLogo(),
            _createInputFields(screenSize),
            _createRegisterLink(),
            _createLoginButton(screenSize),
          ],
        ),
      ),
    );
  }

  _createLogo() {
    return Container();
  }

  _createInputFields(Size screenSize) {
    return Container(
      width: screenSize.width * .8,
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
            _createEmailField(),
            _createPasswordInputField(),
            if (_hasLoginErrors) _createErrorText(),
          ],
        ),
      ),
    );
  }

  Widget _createEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'pladat@dsd.com',
      ),
      initialValue: _user.email ?? '',
      onChanged: (value) {
        setState(() {
          _user.email = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your email';
        } else if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  _createPasswordInputField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon:
              Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      initialValue: _user.password ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Please input your password";
        }
        return null;
      },
      onChanged: (password) => setState(() => _user.password = password),
    );
  }

  _createErrorText() {
    return Text(
      "The password or the email are not correct",
      // TODO: style with error text color when rebranded app.
    );
  }

  _createRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text("Don't have an account?"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            child: Text(
              "Create one here",
              // TODO: style with text color when rebranded app
            ),
            onTap: () =>
                Nav.navigatorKey.currentState.pushNamed("/registration"),
          ),
        ),
      ],
    );
  }

  _createLoginButton(Size screenSize) {
    return SizedBox(
      width: screenSize.width * .8,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: RaisedButton(
          child: Text("Login"),
          onPressed: _loginToPlaDat,
        ),
      ),
    );
  }

  _loginToPlaDat() {
    if (_formKey.currentState.validate()) {
      try {
        AuthService().login(_user).then((response) {
          if (response is bool) {
            // new user, redirect him to the creation of the profile/placement
            Nav.navigatorKey.currentState
                .pushNamed(response ? "/new-student" : "/new-placement");
          } else {
            Nav.navigatorKey.currentState.pushNamed(
                response is Student ? "/placement-list" : "/student-list");
          }
        });
      } on LoginAPIException catch (e) {
        Fluttertoast.showToast(msg: e.message);
      }
    }
  }
}

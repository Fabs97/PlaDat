import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/models/user.dart';
import 'dart:html' show window;
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/api_services/login_api_service.dart';
import 'package:frontend/utils/routes_generator.dart';

class AuthException implements Exception {}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User _loggedUser;
  dynamic _loggedAccountInfo;
  String _jwtToken;

  String get jwtToken {
    if (this._jwtToken == null) {
      this._jwtToken = window.sessionStorage.containsKey("jwtToken")
          ? window.sessionStorage["jwtToken"]
          : throw AuthException();
    }
    return this._jwtToken;
  }

  User get loggedUser {
    if (this._loggedUser == null) {
      final localStorageUser = window.sessionStorage["user"];
      if (localStorageUser == null) {
        Fluttertoast.showToast(msg: "Fatal error occurred, please login again");
        Nav.currentState.popAndPushNamed("/login");
      } else {
        this._loggedUser = User.fromJson(jsonDecode(localStorageUser));
      }
    }
    return this._loggedUser;
  }

  dynamic get loggedAccountInfo {
    if (this._loggedAccountInfo == null) {
      final localStorageAccount = window.sessionStorage["accountInfo"];
      if (localStorageAccount == null) {
        Fluttertoast.showToast(msg: "Fatal error occurred, please login again");
        Nav.currentState.popAndPushNamed("/login");
      } else {
        this._loggedAccountInfo = this.loggedUser.type == AccountType.Employer
            ? Employer.fromJson(jsonDecode(localStorageAccount))
            : Student.fromJson(jsonDecode(localStorageAccount));
      }
    }
    return this._loggedAccountInfo;
  }

  void updateToken(String token) {
    window.sessionStorage["jwtToken"] = token;
    this._jwtToken = token;
  }

  void setLoggedAccountInfo(AccountType accountType, int id) async {
    this._loggedAccountInfo = await (accountType == AccountType.Student
        ? APIService.route(
            ENDPOINTS.Student,
            "/student/:id",
            urlArgs: id,
          )
        : APIService.route(
            ENDPOINTS.Employers,
            "/employer/:id",
            urlArgs: id,
          ));
  }

  dynamic login(User user) async {
    try {
      final response = await APIService.route(
        ENDPOINTS.Login,
        "/login",
        body: user,
      );
      if (response is Map<String, dynamic>) {
        final studentId = response["studentID"];
        final employerId = response["employerID"];

        if (studentId != null)
          user.type = AccountType.Student;
        else if (employerId != null)
          user.type = AccountType.Employer;
        else
          user.type =
              response["student"] ? AccountType.Student : AccountType.Employer;

        user.id = response["userID"];

        this._loggedUser = user;
        window.sessionStorage["user"] = this._loggedUser.toJson();
        window.sessionStorage["jwtToken"] = response["token"];
        this._jwtToken = response["token"];
        if (studentId != null) {
          this._loggedAccountInfo = await APIService.route(
            ENDPOINTS.Student,
            "/student/:id",
            urlArgs: studentId,
          );
        } else if (employerId != null) {
          this._loggedAccountInfo = await APIService.route(
            ENDPOINTS.Employers,
            "/employer/:id",
            urlArgs: employerId,
          );
        } else if (employerId == null && studentId == null) {
          return response["student"];
        }
        window.sessionStorage["accountInfo"] = this._loggedAccountInfo.toJson();
        return this._loggedAccountInfo;
      }
    } on LoginAPIException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}

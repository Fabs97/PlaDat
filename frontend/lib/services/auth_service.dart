import 'package:frontend/models/employer.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/models/user.dart';
import 'dart:html' show window;
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/api_services/login_api_service.dart';

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
      this._jwtToken = window.localStorage.containsKey("jwtToken")
          ? window.localStorage["jwtToken"]
          : throw AuthException();
    }
    return this._jwtToken;
  }

  User get loggedUser => _loggedUser;

  dynamic get loggedAccountInfo => this._loggedAccountInfo;

  login(User user) async {
    //TODO: test with backend
    try {
      final response = await APIService.route(
        ENDPOINTS.Login,
        "/login",
        body: user,
      );
      if (response is Map<String, dynamic>) {
        // TODO: check if the variables are the same passed down from the backend
        final studentId = response["studentID"];
        final employerId = response["employerID"];
        final isStudent = response["isStudent"];
        user.type = isStudent ? AccountType.Student : AccountType.Employer;
        this._loggedUser = user;
        window.localStorage["jwtToken"] = response["jwtToken"];
        if (studentId != null || employerId != null) {
          this._loggedAccountInfo = await studentId != null
              ? APIService.route(
                  ENDPOINTS.Student,
                  "/student/:id",
                  urlArgs: studentId,
                )
              : APIService.route(
                  ENDPOINTS.Employers,
                  "/employer/:id",
                  urlArgs: employerId,
                );
          return this._loggedAccountInfo;
        } else
          return isStudent;
      }
    } on LoginAPIException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}

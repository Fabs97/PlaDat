import 'package:frontend/models/employer.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final User _loggedUser =
      User(id: 1, email: "julian@bass.uk", type: AccountType.Student);

  User get loggedUser => _loggedUser;

  // TODO: needs to be connected with backend
  dynamic get loggedAccountInfo => _loggedUser.type == AccountType.Student
      ? Student(id: 1, name: "Julian Bass")
      : Employer(id: 1, name: "Google Zurich");
}

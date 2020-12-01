import 'package:frontend/models/student.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final Student _loggedStudent = Student(
    id: 1,
    name: "Julian Bass",
    email: "julian@bass.uk"

  );

  Student get loggedStudent => _loggedStudent;
}

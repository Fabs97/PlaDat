import 'package:frontend/models/degree.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/place.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/work_experience.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final User _loggedUser =
      User(id: 1, email: "julian@bass.uk", type: AccountType.Student);

  User get loggedUser => _loggedUser;

  // TODO: needs to be connected with backend
  dynamic get loggedAccountInfo => _loggedUser.type == AccountType.Student
      ? Student(
          id: 1,
          name: "Julian",
          surname: "Bass",
          location: Place(
            country: "Italy",
            city: "Catania",
          ),
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          educations: [
              EducationExperience(
                major: Major(name: "Computer Science and Engineering"),
                institution: Institution(name: "Politecnico di Milano"),
                degree: Degree(name: "Bachelor"),
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
                description: "This is a description of what I study",
              ),
              EducationExperience(
                major: Major(name: "Computer Science and Engineering"),
                institution: Institution(name: "Politecnico di Milano"),
                degree: Degree(name: "Bachelor"),
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
                description: "This is a description of what I study",
              ),
              EducationExperience(
                major: Major(name: "Computer Science and Engineering"),
                institution: Institution(name: "Politecnico di Milano"),
                degree: Degree(name: "Bachelor"),
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
                description: "This is a description of what I study",
              ),
            ],
          works: [
              WorkExperience(
                companyName: "Google",
                position: "Programmer",
                description: "This is a description about a previous job",
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
              ),
              WorkExperience(
                companyName: "Google",
                position: "Programmer",
                description: "This is a description about a previous job",
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
              ),
              WorkExperience(
                companyName: "Google",
                position: "Programmer",
                description: "This is a description about a previous job",
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
              ),
              WorkExperience(
                companyName: "Google",
                position: "Programmer",
                description: "This is a description about a previous job",
                startPeriod: DateTime.now(),
                endPeriod: DateTime.now(),
              ),
            ],
          skills: {
              "TECH": [
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
              ],
              "SOFT": [
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
                Skill(name: "Skill"),
              ],
            })
      : Employer(id: 1, name: "Google Zurich");
}

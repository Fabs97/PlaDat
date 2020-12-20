import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/profile/local_widgets/education_container.dart';
import 'package:frontend/screens/profile/local_widgets/work_container.dart';
import 'package:frontend/utils/custom_theme.dart';

class StudentProfile extends StatelessWidget {
  final Student student;
  StudentProfile({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createStudentName(themeData),
        _createDescription(),
        _createAddress(screenSize, themeData),
        if (student.educations != null && student.educations.isNotEmpty)
          _createEducationsList(screenSize, themeData),
        if (student.works != null && student.works.isNotEmpty)
          _createWorksList(screenSize, themeData),
        _createSkillsBox(
            screenSize, themeData, student.skills["TECH"], "Technical Skills"),
        _createSkillsBox(
            screenSize, themeData, student.skills["SOFT"], "Soft Skills"),
      ],
    );
  }

  _createStudentName(ThemeData themeData) {
    return Center(
      child: Text(
        "${student.name} ${student.surname}",
        style: themeData.textTheme.headline5.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _createDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Text(
        student.description,
        textAlign: TextAlign.justify,
      ),
    );
  }

  _createAddress(Size screenSize, ThemeData themeData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 8.0),
          child: SizedBox(
            width: screenSize.width * .5,
            child: Text(
              "Address",
              style: themeData.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
        ),
        Container(
          width: screenSize.width * .9,
          decoration: BoxDecoration(
            color: CustomTheme().backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(student.location?.city != null &&
                    student.location?.country != null
                ? "${student.location.city}, ${student.location.country}"
                : "No location has been specified"),
          ),
        )
      ],
    );
  }

  _createEducationsList(Size screenSize, ThemeData themeData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 8.0),
          child: SizedBox(
            width: screenSize.width * .9,
            child: Text(
              "Education",
              style: themeData.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
        ),
        if (student.educations != null && student.educations.isNotEmpty)
          ...student?.educations
              ?.map((education) => ProfileEducationCard(
                    education: education,
                  ))
              ?.toList(),
      ],
    );
  }

  _createWorksList(Size screenSize, ThemeData themeData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 8.0),
          child: SizedBox(
            width: screenSize.width * .9,
            child: Text(
              "Work Experience",
              style: themeData.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
        ),
        if (student.works != null && student.works.isNotEmpty)
          ...student?.works
              ?.map((work) => ProfileWorkCard(work: work))
              ?.toList(),
      ],
    );
  }

  _createSkillsBox(
      Size screenSize, ThemeData themeData, List<Skill> skills, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 8.0),
          child: SizedBox(
            width: screenSize.width * .9,
            child: Text(
              title,
              style: themeData.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: 10.0,
          runSpacing: 10.0,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}

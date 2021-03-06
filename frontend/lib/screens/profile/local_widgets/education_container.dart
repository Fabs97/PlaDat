import 'package:flutter/material.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:intl/intl.dart';

class ProfileEducationCard extends StatelessWidget {
  final EducationExperience education;
  ProfileEducationCard({Key key, @required this.education}) : super(key: key);

  final _formatter = DateFormat('MMM yyyy');

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final customTheme = CustomTheme();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: screenSize.width * .9,
        decoration: BoxDecoration(
          color: customTheme.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${education.degree.name}, ${education.major.name}",
                style: themeData.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${education.institution.name}",
                style: themeData.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: customTheme.primaryColor),
              ),
              Text(
                "${_formatter.format(education.startPeriod)} - ${_formatter.format(education.endPeriod)}",
                style: themeData.textTheme.caption.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "${education.description}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

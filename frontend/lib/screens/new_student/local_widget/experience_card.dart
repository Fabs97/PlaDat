import 'package:flutter/material.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:intl/intl.dart';

class ExperienceCard extends StatelessWidget {
  final dynamic experience;
  const ExperienceCard({Key key, this.experience}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEducation = experience is EducationExperience;
    final formatter = DateFormat('dd/MMM/yyyy');
    final screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 5.0,
      child: SizedBox(
        width: screenSize.width * .8,
        height: screenSize.height * .11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEducation
                  ? "${experience.major.name}, ${experience.institution.name}"
                  : "${experience.position}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${formatter.format(experience.startPeriod)} - ${formatter.format(experience.endPeriod)}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "${experience.description}",
            ),
          ],
        ),
      ),
    );
  }
}

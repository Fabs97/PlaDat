import 'package:flutter/material.dart';
import 'package:frontend/models/education_experience.dart';

class ExperienceCard extends StatelessWidget {
  final dynamic experience;
  const ExperienceCard({Key key, this.experience}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEducation = experience is EducationExperience;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 5.0,
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
                isEducation
                    ? "${experience.period}"
                    : "${experience.workPeriod}",
              ),
              Spacer(),
              Text(
                "${experience.description}",
              ),
            ],
          ),
        );
      },
    );
  }
}

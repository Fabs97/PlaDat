import 'package:flutter/material.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:frontend/utils/custom_theme.dart';
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
        height: screenSize.height * .13,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isEducation
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${experience.degree.name}, ${experience.major.name}",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: CustomTheme().textColor),
                        ),
                        Text(
                          "${experience.institution.name}",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: CustomTheme().primaryColor),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "${experience.position} at ",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: CustomTheme().textColor),
                        ),
                        Text(
                          "${experience.companyName}",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: CustomTheme().primaryColor),
                        )
                      ],
                    ),
              Text(
                "${formatter.format(experience.startPeriod)} - ${formatter.format(experience.endPeriod)}",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontStyle: FontStyle.italic,
                    fontSize: 12.0,
                    color: CustomTheme().textColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "${experience.description}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

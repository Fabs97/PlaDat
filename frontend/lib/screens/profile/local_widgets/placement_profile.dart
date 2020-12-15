import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/skill.dart';
import 'package:intl/intl.dart';

class PlacementProfile extends StatelessWidget {
  final Placement placement;
  const PlacementProfile({Key key, this.placement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        _createTitle(themeData),
        _createDescription(),
        _createAddress(screenSize, themeData),
        _createDetails(screenSize, themeData),
        _createSkillsBox(screenSize, themeData, placement.skills["TECH"] ?? [],
            "Technical Skills"),
        _createSkillsBox(
            screenSize, themeData, placement.skills["SOFT"] ?? [], "Soft Skills"),
        _createSkillsBox(
            screenSize, themeData, placement.skills["OTHER"] ?? [], "Other Skills"),
      ],
    );
  }

  _createTitle(ThemeData themeData) {
    return Center(
      child: Column(
        children: [
          Text(
            placement.position,
            style: themeData.textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            placement.employerName,
            style: themeData.textTheme.headline6,
          ),
        ],
      ),
    );
  }

  _createDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Text(
        placement.description,
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
            // TODO: refactor with background color rebranding
            color: Color(0xfff2f6ff),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
                "${placement.location.city}, ${placement.location.country}"),
          ),
        )
      ],
    );
  }

  _createDetails(Size screenSize, ThemeData themeData) {
    final formatter = DateFormat("MMM yyyy");
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
        Row(
          children: [
            _createPlacementWorkingInfoBox(
              "Working period",
              "from ${formatter.format(placement.startPeriod)} to ${formatter.format(placement.endPeriod)}",
            ),
            _createPlacementWorkingInfoBox(
              "Contract type",
              placement.employmentType.niceString,
            ),
            _createPlacementWorkingInfoBox(
              "Salary",
              "${placement.salary} £",
            ),
          ],
        )
      ],
    );
  }

  _createPlacementWorkingInfoBox(String title, String subTitle) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            // TODO: refactor after rebranding
            color: Color(0xfff2f6ff),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
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

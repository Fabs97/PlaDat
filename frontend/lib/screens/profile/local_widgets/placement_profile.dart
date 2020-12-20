import 'package:flutter/material.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:intl/intl.dart';

class PlacementProfile extends StatefulWidget {
  final Placement placement;
  const PlacementProfile({Key key, this.placement}) : super(key: key);

  @override
  _PlacementProfileState createState() => _PlacementProfileState();
}

class _PlacementProfileState extends State<PlacementProfile> {
  Employer _employer;
  @override
  void initState() {
    APIService.route(
      ENDPOINTS.Employers,
      "/employer/:id",
      urlArgs: widget.placement.employerId,
    ).then((employer) => setState(() {
          _employer = employer;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    final techSkills = widget.placement.skills["TECH"];
    final softSkills = widget.placement.skills["SOFT"];
    final otherSkills = widget.placement.skills["OTHER"];
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _employer != null
          ? [
              _createTitle(themeData),
              _createDescription(),
              _createAddress(screenSize, themeData),
              _createDetails(screenSize, themeData),
              if (techSkills != null && techSkills.isNotEmpty)
                _createSkillsBox(
                    screenSize, themeData, techSkills, "Technical Skills"),
              if (softSkills != null && softSkills.isNotEmpty)
                _createSkillsBox(
                    screenSize, themeData, softSkills, "Soft Skills"),
              if (otherSkills != null && otherSkills.isNotEmpty)
                _createSkillsBox(
                    screenSize, themeData, otherSkills, "Other Skills"),
            ]
          : [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
    );
  }

  _createTitle(ThemeData themeData) {
    return Center(
      child: Column(
        children: [
          Text(
            widget.placement?.position ?? "Unknown",
            style: themeData.textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _employer.name ?? "Unknown",
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
        widget.placement.description,
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
            child: Text(_employer.location != null
                ? "${_employer.location}"
                : "No location has been specified"),
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
              "Details",
              style: themeData.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenSize.height * .1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createPlacementWorkingInfoBox(
                "Working period",
                "from ${formatter.format(widget.placement.startPeriod)} to ${formatter.format(widget.placement.endPeriod)}",
              ),
              _createPlacementWorkingInfoBox(
                "Contract type",
                widget.placement.employmentType.niceString,
              ),
              _createPlacementWorkingInfoBox(
                "Salary",
                "${widget.placement.salary} £",
              ),
            ],
          ),
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
            color: CustomTheme().backgroundColor
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

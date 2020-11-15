import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/widgets/card_skills_info.dart';

class PlacementCard extends StatelessWidget {
  final Placement placement;

  const PlacementCard({Key key, this.placement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _createPlacementTitle(size, Theme.of(context).textTheme),
            _createPlacementDescription(placement.description),
            _createPlacementWorkingInfo(),
            CardSkillsChips(
                title: "Technical skills", skills: ["Java", "CSS", "HTML", "JavaScript"]),
            CardSkillsChips(
                title: "Soft skills", skills: ["Java", "CSS", "HTML", "JavaScript"]),
          ],
        ),
      ),
    );
  }

  Widget _createPlacementTitle(Size size, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // Image container
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("/images/image0.jpg"),
                  fit: BoxFit.fill,
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            width: size.width * .2,
            height: size.width * .2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placement.position,
                  style: textTheme.headline4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Company name",
                  style: textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0), // TODO: fix this padding
                  child: Text(
                    "Find out more",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _createPlacementDescription(String description) {
    return Text(description);
  }

  Widget _createPlacementWorkingInfo() {
    final startMonth = placement.startPeriod.month;
    final endMonth = placement.endPeriod.month;
    final endYear = placement.endPeriod.year;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _createPlacementWorkingInfoBox("Working period", "from $startMonth to $endMonth $endYear"),
        _createPlacementWorkingInfoBox(
            "Working hours", "${placement.workingHours} hours a week"),
        _createPlacementWorkingInfoBox("Salary", "${placement.salary} €"),
      ],
    );
  }

  Widget _createPlacementWorkingInfoBox(String title, String subTitle) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(subTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

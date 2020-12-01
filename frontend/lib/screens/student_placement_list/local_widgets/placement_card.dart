import 'package:auto_size_text/auto_size_text.dart';
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
            Expanded(
              child: _createPlacementTitle(size, Theme.of(context).textTheme),
              flex: 2,
            ),
            Expanded(
              child: _createPlacementDescription(placement.description, size),
              flex: 1,
            ),
            Expanded(
              child: _createPlacementWorkingInfo(),
              flex: 1,
            ),
            Expanded(
              child: CardSkillsChips(
                  title: "Technical skills",
                  skills: placement.skills["TECH"] ?? []),
              flex: 1,
            ),
            Expanded(
              child: CardSkillsChips(
                  title: "Soft skills", skills: placement.skills["SOFT"] ?? []),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createPlacementTitle(Size size, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // Image container
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/image0.jpg"),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.loose(
                  Size(
                    size.width * .5,
                    size.height * .2,
                  ),
                ),
                child: AutoSizeText(
                  placement.position,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: textTheme.headline4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Company name",
                style: textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
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
    );
  }

  Widget _createPlacementDescription(String description, Size screenSize) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        Size(
          screenSize.width * .8,
          screenSize.height * .3,
        ),
      ),
      child: AutoSizeText(
        description,
        maxLines: 5,
      ),
    );
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
        _createPlacementWorkingInfoBox(
            "Working period", "from $startMonth to $endMonth $endYear"),
        _createPlacementWorkingInfoBox(
            "Working hours", "${placement.workingHours} hours a week"),
        _createPlacementWorkingInfoBox("Salary", "${placement.salary} €"),
      ],
    );
  }

  Widget _createPlacementWorkingInfoBox(String title, String subTitle) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
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
}

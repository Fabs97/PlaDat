import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/card_skills_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PlacementCard extends StatelessWidget {
  final Placement placement;

  PlacementCard({Key key, this.placement}) : super(key: key);
  final _longDateFormatter = DateFormat("MMM yyyy");
  final _compactDateFormatter = DateFormat("MMM");
  final _salaryFormatter =
      NumberFormat.compactCurrency(locale: "en_US", symbol: "£ ");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Card(
      shadowColor: Color(0xffced5ff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Color(0xffced5ff),
          width: 8.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _createPlacementTitle(screenSize, Theme.of(context).textTheme),
            _createPlacementDescription(placement.description, screenSize),
            _createPlacementWorkingInfo(screenSize, themeData),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CardSkillsChips(
                  title: "Technical skills",
                  skills: placement.skills["TECH"] ?? []),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CardSkillsChips(
                  title: "Soft skills", skills: placement.skills["SOFT"] ?? []),
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
                  style: textTheme.headline5.copyWith(
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    color: CustomTheme().textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                "Company name",
                style: textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              FlatButton(
                color: Colors.transparent,
                child: Text(
                  "Find out more",
                  style: textTheme.subtitle1.copyWith(
                    color: CustomTheme().secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () => Nav.currentState.pushNamed(
                  "/profile",
                  arguments: placement,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _createPlacementDescription(String description, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ConstrainedBox(
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
      ),
    );
  }

  Widget _createPlacementWorkingInfo(Size screenSize, ThemeData themeData) {
    return Container(
      height: screenSize.height * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _createPlacementWorkingInfoBox(
              "Working period",
              placement.startPeriod.year != placement.endPeriod.year
                  ? "from ${_longDateFormatter.format(placement.startPeriod)} to ${_longDateFormatter.format(placement.endPeriod)}"
                  : "from ${_compactDateFormatter.format(placement.startPeriod)} to ${_longDateFormatter.format(placement.endPeriod)}",
              themeData),
          _createPlacementWorkingInfoBox(
              "Type", "${placement.employmentType.niceString}", themeData),
          _createPlacementWorkingInfoBox("Salary",
              "${_salaryFormatter.format(placement.salary)}", themeData),
        ],
      ),
    );
  }

  Widget _createPlacementWorkingInfoBox(
      String title, String subTitle, ThemeData themeData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: CustomTheme().backgroundColor,
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
                  style: themeData.textTheme.caption.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

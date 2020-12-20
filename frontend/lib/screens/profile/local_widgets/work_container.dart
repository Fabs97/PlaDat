import 'package:flutter/material.dart';
import 'package:frontend/models/work_experience.dart';
import 'package:intl/intl.dart';

class ProfileWorkCard extends StatelessWidget {
  final WorkExperience work;
  ProfileWorkCard({Key key, @required this.work}) : super(key: key);

  final _formatter = DateFormat('MMM yyyy');

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: screenSize.width * .9,
        decoration: BoxDecoration(
          // TODO: refactor with background color rebranding
          color: Color(0xfff2f6ff),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: themeData.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(text: "${work.position} at "),
                    TextSpan(
                      text: "${work.companyName}",
                      style: TextStyle(
                        color: Color(0xff4c60d2),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${_formatter.format(work.startPeriod)} - ${_formatter.format(work.endPeriod)}",
                style: themeData.textTheme.caption.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "${work.description}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

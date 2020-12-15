import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/card_skills_info.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  const StudentCard({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            Expanded(
              child: _createStudentTitle(size, Theme.of(context).textTheme),
              flex: 2,
            ),
            Expanded(
              child: _createStudentDescription(
                  "This is a description about me..."),
              flex: 1,
            ),
            Expanded(
              child: _createStudentInfo(),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CardSkillsChips(
                    title: "Technical skills",
                    skills: student.skills["TECH"] ?? []),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CardSkillsChips(
                    title: "Soft skills", skills: student.skills["SOFT"] ?? []),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createStudentTitle(Size size, TextTheme textTheme) {
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
                    size.width * .7,
                    size.height * .1,
                  ),
                ),
                child: AutoSizeText("${student.name} ${student.surname}",
                    style: TextStyle(
                        color: CustomTheme().textColor, fontSize: 20)),
              ),
              Text(
                "Find out more",
                style: TextStyle(
                  color: CustomTheme().secondaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _createStudentDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(description),
    );
  }

  Widget _createStudentInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _createStudentInfoBox("School of Life", "Jan 2020 - July 2022"),
        _createStudentInfoBox("School of Life", "Jan 2020 - July 2022"),
      ],
    );
  }

  Widget _createStudentInfoBox(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomTheme().backgroundColor,
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
    );
  }
}

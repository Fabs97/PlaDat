import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/otherskills.dart';
import 'package:frontend/widgets/skillsbox.dart';
import 'package:frontend/services/api_service.dart';
import 'package:provider/provider.dart';

class SkillsForm extends StatelessWidget {
  final List<dynamic> skillsBoxes = [
    SkillBox(
      title: "Technical skills",
      skillsType: "TECH",
    ),
    SkillBox(
      title: "Soft skills",
      skillsType: "SOFT",
    ),
    OtherSkills()
  ];

  @override
  Widget build(BuildContext context) {
    final placement = Provider.of<Placement>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      height: size.height * .85,
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: size.height * .7,
              child: ListView.builder(
                itemCount: skillsBoxes.length,
                itemBuilder: (_, index) => skillsBoxes[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.grey[600],
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _savePlacementToDB(context, placement),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePlacementToDB(BuildContext context, Placement placement) async {
    placement.skills = {
      "technicalSkills": skillsBoxes[0].chosenSkills,
      "softSkills": skillsBoxes[1].chosenSkills,
      "otherSkills": skillsBoxes[2].otherSkills,
    };

    Placement newPlacement = await APIService.route(
        ENDPOINTS.Placement, "/placement/new-placement",
        body: placement);
    print(newPlacement);

    Nav.currentState.popAndPushNamed("/employer-home");
  }
}

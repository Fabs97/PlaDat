import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:frontend/screens/new_placement/local_widgets/placement_form.dart';
import 'package:frontend/screens/new_placement/local_widgets/skills_form.dart';

class NewPlacement extends StatefulWidget {
  const NewPlacement({Key key}) : super(key: key);

  @override
  _NewPlacementState createState() => _NewPlacementState();
}

class _NewPlacementState extends State<NewPlacement> {
  bool _firstStep = true;

  void changeStep(bool step) {
    setState(() {
      _firstStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar.createAppBar(context, "Create Placement"),
      appBar: AppBar(
        title: Text(
          "Create Placement",
          textAlign: TextAlign.center,
        ),
        leading: _firstStep
            ? null
            : GestureDetector(
                onTap: () => changeStep(true),
                child: Icon(Icons.arrow_back),
              ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            _firstStep ? PlacementForm(changeStep: changeStep) : SkillsForm(),
          ],
        ),
      ),
    );
  }
}

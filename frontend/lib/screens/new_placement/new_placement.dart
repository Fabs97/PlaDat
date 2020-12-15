import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/screens/new_placement/local_widgets/placement_form.dart';
import 'package:frontend/screens/new_placement/local_widgets/skills_form.dart';
import 'package:provider/provider.dart';

class NewPlacement extends StatefulWidget {
  const NewPlacement({Key key}) : super(key: key);

  @override
  _NewPlacementState createState() => _NewPlacementState();
}

class _NewPlacementState extends State<NewPlacement> {
  bool _firstStep = true;
  Placement _newPlacement = Placement();

  void changeStep(bool step) {
    setState(() {
      _firstStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _newPlacement,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Create Placement",
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          leading: _firstStep
              ? null
              : IconButton(
                  onPressed: () => changeStep(true),
                  icon: Icon(Icons.arrow_back),
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
      ),
    );
  }
}

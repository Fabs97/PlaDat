import 'package:flutter/material.dart';
import 'package:frontend/models/employer.dart';
import 'package:provider/provider.dart';

import 'local_widget/employer_form.dart';


class FormStepper extends ChangeNotifier {
  int step = 0;

  void goToPreviousFormStep() {
    step = step == 0 ? 0 : step -= 1;
    notifyListeners();
  }

  void goToNextFormStep() {
    step += 1;
    notifyListeners();
  }
}

class NewEmployer extends StatefulWidget {
  @override
  _NewEmployerState createState() => _NewEmployerState();
}

class _NewEmployerState extends State<NewEmployer> {

  final _steps = [
    EmployerForm(),
  ];
  


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Employer(),
        ),
        
        ChangeNotifierProvider.value(
          value: FormStepper(),
        ),
      ],
      builder: (context, _) {
        final stepper = context.watch<FormStepper>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Company Profile",
              textAlign: TextAlign.center,
            ),
            elevation: 0,
            leading: stepper.step == 0
                ? null
                : IconButton(
                    onPressed: () => stepper.goToPreviousFormStep(),
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
                _steps[stepper.step],
              ],
            ),
          ),
        );
      },
    );
  }
}

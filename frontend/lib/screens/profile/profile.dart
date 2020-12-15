import 'package:flutter/material.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/profile/local_widgets/employer_profile.dart';
import 'package:frontend/screens/profile/local_widgets/student_profile.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class Profile extends StatelessWidget {
  final dynamic profile = AuthService().loggedAccountInfo;
  Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "My Profile"),
      drawer: CustomDrawer.createDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              width: constraints.biggest.width * .95,
              height: constraints.biggest.height * .95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: profile is Student
                      ? StudentProfile(student: profile)
                      : EmployerProfile(employer: profile),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

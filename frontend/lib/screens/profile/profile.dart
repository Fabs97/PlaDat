import 'package:flutter/material.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/profile/local_widgets/placement_profile.dart';
import 'package:frontend/screens/profile/local_widgets/student_profile.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class Profile extends StatelessWidget {
  final dynamic profile;
  Profile({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(
        context,
        profile is Student
            ? (AuthService().loggedAccountInfo is Employer
                ? "Student Profile"
                : "My profile")
            : "Placement Profile",
      ),
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
                      : PlacementProfile(placement: profile),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

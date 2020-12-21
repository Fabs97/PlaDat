import 'package:flutter/material.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/profile/local_widgets/placement_profile.dart';
import 'package:frontend/screens/profile/local_widgets/student_profile.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';

class Profile extends StatefulWidget {
  final dynamic profile;
  Profile({Key key, @required this.profile}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.profile is Student
              ? (widget.profile.id != AuthService().loggedAccountInfo.id &&
                      AuthService().loggedAccountInfo is Employer
                  ? "Student Profile"
                  : "My profile")
              : "Placement Profile",
        ),
        actions: [
          widget.profile is Placement &&
                  widget.profile.employerId ==
                      AuthService().loggedAccountInfo.id &&
                  AuthService().loggedAccountInfo is Employer
              ? PopupMenuButton<String>(
                  icon: Icon(
                    Icons.settings,
                    color: CustomTheme().primaryColor,
                  ),
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                        child: ListTile(
                      leading: Icon(
                        Icons.stop_circle_outlined,
                        color: CustomTheme().secondaryColor,
                      ),
                      title: Text(
                        "Close the application",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: CustomTheme().secondaryColor,
                            ),
                      ),
                      onTap: () {
                        setState(() {
                          // TODO: change status of the placement with closed
                          widget.profile.status = "CLOSED";
                          Navigator.pop(context);
                        });
                      },
                    ))
                  ],
                )
              : Container(),
        ],
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
                  child: widget.profile is Student
                      ? StudentProfile(student: widget.profile)
                      : PlacementProfile(placement: widget.profile),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

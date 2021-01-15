import 'dart:convert';
import 'dart:html' show window;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/employer.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/profile/local_widgets/placement_profile.dart';
import 'package:frontend/screens/profile/local_widgets/student_profile.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';

class Profile extends StatefulWidget {
  final dynamic profile;
  Profile({Key key, @required this.profile}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic profile;

  @override
  void initState() {
    super.initState();
    if (widget.profile != null) {
      window.sessionStorage["profile"] = widget.profile.toJson();
      window.sessionStorage["profileType"] =
          widget.profile is Student ? "Student" : "Placement";
      profile = widget.profile;
    } else {
      final sessionStorageProfile = window.sessionStorage["profile"];
      if (sessionStorageProfile == null)
        profile = null;
      else {
        switch (window.sessionStorage["profileType"]) {
          case "Student":
            {
              profile = Student.fromJson(jsonDecode(sessionStorageProfile));
              break;
            }
          case "Placement":
            {
              profile = Placement.fromJson(jsonDecode(sessionStorageProfile));
              break;
            }
          default:
            {
              profile = null;
              break;
            }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedAccountInfo = AuthService().loggedAccountInfo;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          profile is Student
              ? (profile.id != loggedAccountInfo.id &&
                      loggedAccountInfo is Employer
                  ? "Student Profile"
                  : "My profile")
              : "Placement Profile",
        ),
        actions: [
          profile is Placement &&
                  profile.employerId == loggedAccountInfo.id &&
                  loggedAccountInfo is Employer
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    'Are you sure you want to close the application? \nThe students won’t see the placement anymore in their recommendations'),
                                actions: [
                                  FlatButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        APIService.route(ENDPOINTS.Placement,
                                                "/placement/:id/close",
                                                urlArgs: profile.id)
                                            .then((value) => setState(() {
                                                  value is String
                                                      ? profile.status =
                                                          "CLOSED"
                                                      : Fluttertoast.showToast(
                                                          msg: value);
                                                  Navigator.pop(context);
                                                }));
                                        Navigator.pop(context);
                                      }),
                                ],
                              );
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
              child: profile != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: profile is Student
                            ? StudentProfile(student: profile)
                            : PlacementProfile(placement: profile),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "I could not retrieve correctly the information, please go back and try again."),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

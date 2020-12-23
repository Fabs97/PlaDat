import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:frontend/screens/company_placement_list/local_widgets/chips_list.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/drawer.dart';

class PlacementMatchedStudents extends StatefulWidget {
  final Placement placement;

  PlacementMatchedStudents({Key key, @required this.placement})
      : super(key: key);

  @override
  _PlacementMatchedStudentsState createState() =>
      _PlacementMatchedStudentsState();
}

class _PlacementMatchedStudentsState extends State<PlacementMatchedStudents> {
  List<Student> _students;

  @override
  void initState() {
    APIService.route(ENDPOINTS.Placement, '/placement/:placementId/students',
            urlArgs: widget.placement.id)
        .then((studentList) => setState(() {
              _students = studentList;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matched Student",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      drawer: CustomDrawer.createDrawer(context),
      body: Center(
        child: Container(
          height: screenSize.height * .9,
          width: screenSize.width * .855,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${widget.placement.position}',
                      style: themeData.textTheme.headline6.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme().primaryColor),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        APIService.route(
                          ENDPOINTS.Placement,
                          "/placement/:id",
                          urlArgs: widget.placement.id,
                        ).then((response) {
                          if (response is Placement) {
                            Nav.navigatorKey.currentState
                                .pushNamed("/profile", arguments: response);
                          } else {
                            Fluttertoast.showToast(msg: response);
                          }
                        }).catchError((error) =>
                            Fluttertoast.showToast(msg: error.toString()));
                      },
                      color: Colors.transparent,
                      child: Text(
                        'See more',
                        style: themeData.textTheme.bodyText1.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme().secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _students == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [CustomTheme().boxShadow],
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        width: screenSize.width * .855,
                        height: screenSize.height * .845,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ListView.builder(
                            itemCount: _students.length,
                            itemBuilder: (context, index) {
                              final _student = _students[index];
                              final _techSkills = _student.skills["TECH"];
                              final _softSkills = _student.skills["SOFT"];
                              final _skills = _techSkills + _softSkills;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 0.0,
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                            "${_student.name} ${_student.surname}"),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [
                                                Flexible(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 15.0),
                                                        child: Text(
                                                            "${_student.description}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)))
                                              ]),
                                              Wrap(children: [
                                                ListChips(
                                                  skills: _skills.sublist(
                                                      0,
                                                      4 < _skills.length
                                                          ? 4
                                                          : _skills.length),
                                                ),
                                              ]),
                                            ]),
                                        trailing: PopupMenuButton<String>(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context) =>
                                              <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.email,
                                                  color: CustomTheme()
                                                      .secondaryColor ,
                                                ),
                                                title: Text(
                                                  "Send message",
                                                  style: themeData
                                                      .textTheme.subtitle1
                                                      .copyWith(
                                                    color: CustomTheme()
                                                        .secondaryColor,
                                                  ),
                                                ),
                                                onTap: () => Nav
                                                    .navigatorKey.currentState
                                                    .pushNamed("/chat-screen",
                                                        arguments:
                                                            ChatScreenArguments(
                                                                _student.id,
                                                                widget.placement
                                                                    .employerId)),
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              child: ListTile(
                                                leading: Icon(Icons.delete,
                                                    color: CustomTheme()
                                                        .primaryColor),
                                                title: Text(
                                                  "Remove the match",
                                                ),
                                                onTap: () => _showConfirmDialog(
                                                    _student),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Divider(
                                        thickness: 1.0,
                                        color: Color(0xffcecece),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _showConfirmDialog(Student student) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to remove the match?'),
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
                  APIService.route(
                          ENDPOINTS.Matches, "/match/:studentId/:placementId",
                          urlArgs: Match(
                              placementID: widget.placement.id,
                              studentID: student.id))
                      .then((value) => setState(() {
                            print(value);
                            if (value is bool && value) {
                              _students.remove(student);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(msg: value);
                            }
                          }));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

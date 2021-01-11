import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/drawer.dart';

class StudentMatches extends StatefulWidget {
  @override
  _StudentMatchesState createState() => _StudentMatchesState();
}

class _StudentMatchesState extends State<StudentMatches> {
  List<Placement> _placements;
  int _studentId = AuthService().loggedAccountInfo.id;
  @override
  void initState() {
    APIService.route(ENDPOINTS.Student, "/student/{studentId}/placements",
            urlArgs: _studentId)
        .then((placementList) => setState(() {
              _placements = placementList;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Matched Placements",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      drawer: CustomDrawer.createDrawer(context),
      body: _placements == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                    itemCount: _placements.length,
                    itemBuilder: (context, index) {
                      final _placement = _placements[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: Column(
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  child: Icon(Icons.work, color: Colors.white),
                                  decoration: BoxDecoration(
                                    color: CustomTheme().primaryColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(_placement.position + " No.$index",
                                style: themeData.textTheme.bodyText1.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            subtitle: Text(
                              _placement.employerName +
                                  '\n${_placement.description}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: themeData.textTheme.bodyText2.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            trailing: PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: CustomTheme().primaryColor,
                                size: 36,
                              ),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.email,
                                      color: CustomTheme().secondaryColor,
                                    ),
                                    title: Text(
                                      "Send message",
                                      style: themeData.textTheme.subtitle1
                                          .copyWith(
                                        color: CustomTheme().secondaryColor,
                                      ),
                                    ),
                                    onTap: () => Nav.currentState.pushNamed(
                                        "/chat-screen",
                                        arguments: ChatScreenArguments(
                                            _studentId, _placement.employerId)),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  child: ListTile(
                                    leading: Icon(Icons.delete,
                                        color: CustomTheme().primaryColor),
                                    title: Text(
                                      "Remove the match",
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure you want to remove the match?'),
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
                                                            ENDPOINTS.Matches,
                                                            "/match/:studentId/:placementId",
                                                            urlArgs: Match(
                                                                studentID:
                                                                    _studentId,
                                                                placementID:
                                                                    _placements[
                                                                            index]
                                                                        .id))
                                                        .then((value) =>
                                                            setState(() {
                                                              print(value);
                                                              if (value
                                                                      is bool &&
                                                                  value) {
                                                                _placements.remove(
                                                                    _placement);
                                                                Navigator.pop(
                                                                    context);
                                                              } else {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            value);
                                                              }
                                                            }));
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              thickness: 1.0,
                              color: Color(0xffcecece),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

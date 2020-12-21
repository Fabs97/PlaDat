import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/screens/company_placement_list/local_widgets/placement_matched_students.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/drawer.dart';

class MyPlacements extends StatefulWidget {
  MyPlacements({Key key}) : super(key: key);

  @override
  _MyPlacementsState createState() => _MyPlacementsState();
}

class _MyPlacementsState extends State<MyPlacements> {
  List<Placement> _placements;
  int _employerId = 1;

  @override
  void initState() {
    APIService.route(ENDPOINTS.Employers, "/employer/:employerId/placements",
            urlArgs: _employerId)
        .then((placementsList) => setState(() {
              _placements = placementsList;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Placement"),
        actions: [
          IconButton(
              padding: EdgeInsets.all(10.0),
              iconSize: 40,
              icon: Icon(
                Icons.fiber_new_rounded,
                color: CustomTheme().primaryColor,
              ),
              onPressed: () {
                Nav.navigatorKey.currentState.pushNamed("/new-placement");
              }),
        ],
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 0.0,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _placement.position + " No.$index",
                                style: themeData.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "${_placement.countMatches ?? 0} matches",
                                    style: themeData.textTheme.caption.copyWith(
                                      color: CustomTheme().secondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  _placement.status == "CLOSED"
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0,
                                            vertical: 4.0,
                                          ),
                                          child: Transform(
                                            transform: Matrix4.identity()
                                              ..scale(0.8),
                                            child: Chip(
                                                backgroundColor: Colors.white,
                                                label: Text("CLOSED"),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    side: BorderSide(
                                                        color: CustomTheme()
                                                            .primaryColor)),
                                                labelStyle: TextStyle(
                                                    color: CustomTheme()
                                                        .primaryColor,
                                                    backgroundColor:
                                                        Colors.white)),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                              onTap: () {
                                if (_placement.countMatches == null) {
                                  APIService.route(
                                          ENDPOINTS.Placement, "/placement/:id",
                                          urlArgs: _placement.id)
                                      .then((placement) {
                                    Nav.navigatorKey.currentState.pushNamed(
                                      "/profile",
                                      arguments: placement,
                                    );
                                  }).catchError((error) {
                                    Fluttertoast.showToast(
                                        msg: error.message ?? error.toString());
                                  });
                                } else {
                                  Nav.navigatorKey.currentState
                                      .push(MaterialPageRoute(
                                    builder: (builder) =>
                                        PlacementMatchedStudents(
                                            placement: _placement),
                                  ));
                                }
                              },
                              trailing: PopupMenuButton<String>(
                                itemBuilder: (context) =>
                                    <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                      child: ListTile(
                                    leading: Icon(
                                      Icons.stop_circle_outlined,
                                      color: CustomTheme().secondaryColor,
                                    ),
                                    title: Text(
                                      "Close the application",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
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
                                                      APIService.route(
                                                              ENDPOINTS
                                                                  .Placement,
                                                              "/placement/:id/close",
                                                              urlArgs:
                                                                  _placement.id)
                                                          .then((value) =>
                                                              setState(() {
                                                                _placement
                                                                        .status =
                                                                    'CLOSED';
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                      Navigator.pop(context);
                                                    }),
                                              ],
                                            );
                                          });
                                    },
                                  ))
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
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

_showConfirmDialog(Placement placement) {}

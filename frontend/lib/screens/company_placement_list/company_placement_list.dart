import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/screens/company_placement_list/local_widgets/placement_matched_students.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class MyPlacements extends StatefulWidget {
  MyPlacements({Key key}) : super(key: key);

  @override
  _MyPlacementsState createState() => _MyPlacementsState();
}

class _MyPlacementsState extends State<MyPlacements> {
  List<Placement> _placements;
  Placement _placement;
  final _employer = AuthService().loggedAccountInfo;
  @override
  void initState() {
    APIService.route(ENDPOINTS.Employers, "/employer/:employerId/placements",
            urlArgs: _employer.id)
        .then((placementsList) => setState(() {
              _placements = placementsList;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "My Placements"),
      drawer: CustomDrawer.createDrawer(context),
      body: _placements == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _placements.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_placements[index].position + " No.$index"),
                    subtitle:
                        Text("${_placements[index].countMatches ?? 0} matches"),
                    onTap: () {
                      if (int.parse(_placements[index].countMatches) > 0) {
                        Nav.navigatorKey.currentState.push(MaterialPageRoute(
                          builder: (builder) => PlacementMatchedStudents(
                              placement: _placements[index]),
                        ));
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

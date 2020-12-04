import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';
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
  int _employerId = 1;

  @override
  void initState() {
    APIService.route(ENDPOINTS.Employers, "/employer/:employerId/placements",
            urlArgs: _employerId)
        .then((placementsList) => setState(() {
              _placements = placementsList;
              //_placement = _placements[0] ?? null;
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
                _placement = _placements[index];
                return Card(
                  child: ListTile(
                    title: Text(_placement.position + " No.$index"),
                    subtitle: Text("matches"),
                  ),
                );
              },
            ),
    );
  }
}

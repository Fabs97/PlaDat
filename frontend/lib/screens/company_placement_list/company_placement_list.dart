import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_theme.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "My Placements"),
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
                      _placement = _placements[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0,),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _placement.position + " No.$index",
                                style: themeData.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                _placement.countMatches != null
                                    ? "${_placement.countMatches}" + " matches"
                                    : "0 matches",
                                style: themeData.textTheme.caption.copyWith(
                                  color: CustomTheme().secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
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

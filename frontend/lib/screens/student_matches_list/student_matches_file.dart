import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class StudentMatches extends StatefulWidget {
  @override
  _StudentMatchesState createState() => _StudentMatchesState();
}

class _StudentMatchesState extends State<StudentMatches> {
  List<Placement> _placements;
  Placement _placement;
  final _student = AuthService().loggedAccountInfo;
  @override
  void initState() {
    APIService.route(ENDPOINTS.Student, "/student/{studentId}/placements",
            urlArgs: _student.id)
        .then((placementList) => setState(() {
              _placements = placementList;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "Matched Placements"),
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
                    leading: Icon(Icons.work),
                    title: Text(_placement.position + " No.$index"),
                    subtitle: Text(_placement.employerName +
                        '\n${_placement.description}'),
                  ),
                );
              },
            ),
    );
  }
}

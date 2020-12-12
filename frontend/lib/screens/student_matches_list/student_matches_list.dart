import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class StudentMatches extends StatefulWidget {
  @override
  _StudentMatchesState createState() => _StudentMatchesState();
}

class _StudentMatchesState extends State<StudentMatches> {
  List<Placement> _placements;
  Placement _placement;
  int _studentId = 1;
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
                      leading: Icon(Icons.work, color: Color(0xff4c60d2)),
                      title: Text(_placement.position + " No.$index"),
                      subtitle: Text(_placement.employerName +
                          '\n${_placement.description}'),
                      trailing: PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            child: ListTile(
                              leading:
                                  Icon(Icons.delete, color: Color(0xff4c60d2)),
                              title: Text("Remove the match",
                                  style: TextStyle(color: Color(0xff4c60d2))),
                              onTap: () {
                                setState(() {
                                  _placements.remove(_placement);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          )
                        ],
                      )),
                );
              },
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/student.dart';

class MatchAlert extends StatelessWidget {
  final Placement placement;
  final dynamic object;

  const MatchAlert({Key key, @required this.placement, @required this.object})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isStudent = object is Student;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations!',
              maxLines: 20,
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'You have a match.',
              maxLines: 20,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            isStudent
                ? Column(
                    children: [
                      Text(
                        object.name + ' ' + object.surname,
                        maxLines: 22,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'School of Life',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Column(
                      children: [
                        Text(
                          'Google, Zurich',
                          maxLines: 20,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
            Text(
              'for',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              placement.position,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

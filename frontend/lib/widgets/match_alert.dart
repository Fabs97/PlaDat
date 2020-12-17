import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';

class MatchAlert extends StatelessWidget {
  final Placement placement;
  final dynamic object;

  const MatchAlert({Key key, @required this.placement, @required this.object})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isStudent = object is Student;
    final themeData = Theme.of(context);
    final customTheme = CustomTheme();
    return Scaffold(
      backgroundColor: customTheme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    'Congratulations!',
                    style: themeData.textTheme.headline4.copyWith(
                      color: customTheme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'You have a match.',
                    style: themeData.textTheme.headline6.copyWith(
                      color: customTheme.secondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    isStudent
                        ? "${object.name} ${object.surname}"
                        : "${placement.employerName}",
                    style: themeData.textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700,
                      color: customTheme.primaryColor,
                    ),
                  ),
                  Text(
                    isStudent ? 'School of Life' : "Zurich",
                    style: themeData.textTheme.headline6.copyWith(
                      color: customTheme.secondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            Text(
              'for',
              style: themeData.textTheme.headline6.copyWith(
                fontStyle: FontStyle.italic,
                color: customTheme.secondaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              placement.position,
              style: themeData.textTheme.headline5.copyWith(
                fontWeight: FontWeight.w700,
                color: customTheme.primaryColor,
              ),
            ),
            SizedBox(
              width: size.width * .8,
              height: size.height * .12,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text(
                    "Start a conversation",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Nav.navigatorKey.currentState
                        .popAndPushNamed("/chat-screen",
                            arguments: ChatScreenArguments(
                              isStudent
                                  ? object.id
                                  : AuthService().loggedAccountInfo.id,
                              placement.employerId,
                            ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

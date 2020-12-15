import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/routes_generator.dart';

class _CustomDrawerPage {
  final String title;
  final String route;

  _CustomDrawerPage(this.title, this.route);
}

class CustomDrawer {
  static List<_CustomDrawerPage> _employerDrawerPages = [
    _CustomDrawerPage("My recommendations", "/student-list"),
    _CustomDrawerPage("My placements", "/company-placements"),
  ];
  static List<_CustomDrawerPage> _studentDrawerPages = [
    _CustomDrawerPage("My recommendations", "/placement-list"),
    _CustomDrawerPage("My matches", "/student-matches"),
  ];

  static Drawer createDrawer(BuildContext context) {
    final bool isStudent = AuthService().loggedUser.type == AccountType.Student;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Welcome to PlaDat"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          _createDrawer(isStudent),
          // ListTile( 
          //   title: Text("Create placement"),
          //   onTap: () =>
          //       Nav.navigatorKey.currentState.pushNamed("/new-placement"),
          // ),
          // ListTile(
          //   title: Text("Create student"),
          //   onTap: () =>
          //       Nav.navigatorKey.currentState.pushNamed("/new-student"),
          // ),
          // ListTile(
          //   title: Text("Register to PlaDat"),
          //   onTap: () =>
          //       Nav.navigatorKey.currentState.pushNamed("/registration"),
          // ),
        ],
      ),
    );
  }

  static _createDrawer(bool isStudent) {
    return (isStudent ? _studentDrawerPages : _employerDrawerPages).map(_createListTile).cast<ListTile>().toList();
  }

  static _createListTile(_CustomDrawerPage page) {
    return ListTile(
      title: Text(page.title),
      onTap: () => Nav.navigatorKey.currentState.pushNamed(page.route),
    );
  }
}

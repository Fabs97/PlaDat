import 'package:flutter/material.dart';
import 'package:frontend/utils/routes_generator.dart';

class CustomDrawer {
  static Drawer createDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Welcome to PlaDat"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("Students list"),
            onTap: () => Nav.navigatorKey.currentState.pushNamed("/student-list"),
          ),
          ListTile(
            title: Text("Placements list"),
            onTap: () => Nav.navigatorKey.currentState.pushNamed("/placement-list"),
          ),
          ListTile(
            title: Text("Create placement"),
            onTap: () => Nav.navigatorKey.currentState.pushNamed("/new-placement"),
          ),
          ListTile(
            title: Text("Create student"),
            onTap: () => Nav.navigatorKey.currentState.pushNamed("/new-student"),
          ),
        ],
      ),
    );
  }
}

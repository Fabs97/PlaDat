import 'package:flutter/material.dart';

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
            onTap: () => Navigator.pushNamed(context, "/student-list"),
          ),
          ListTile(
            title: Text("Placements list"),
            onTap: () => Navigator.pushNamed(context, "/placement-list"),
          ),
          ListTile(
            title: Text("Create placement"),
            onTap: () => Navigator.pushNamed(context, "/new-placement"),
          ),
          ListTile(
            title: Text("Create student"),
            onTap: () => Navigator.pushNamed(context, "/new-student"),
          ),
        ],
      ),
    );
  }
}

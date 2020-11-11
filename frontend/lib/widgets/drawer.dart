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
          // ListTile(
          //   title: Text("Create placement"),
          //   onTap: () => Navigator.pushNamed(context, "/new-placement"),
          // ),
          ListTile(
            title: Text("Students list"),
            onTap: () => Navigator.pushNamed(context, "/student-list"),
          ),
        ],
      ),
    );
  }
}

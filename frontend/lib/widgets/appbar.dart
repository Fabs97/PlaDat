import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar createAppBar(BuildContext context, String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
      ),
      elevation: 0,
    );
  }
}

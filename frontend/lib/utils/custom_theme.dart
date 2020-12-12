import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  final _backgroundColor = Color(0xfff2f6ff);
  final _primaryColor = Color(0xff4c60d2);
  final _secondaryColor = Color(0xfff48565);
  final _accentColor = Color(0xffffd9cf);
  final _textColor = Color(0xff4c4c4c);

  ThemeData get appThemeData => ThemeData(
        primaryColor: _backgroundColor,
        accentColor: _accentColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: _primaryColor),
          textTheme: TextTheme(
            headline6: GoogleFonts.roboto(
              color: _primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: _secondaryColor,
          secondarySelectedColor: _secondaryColor,
          selectedColor: _secondaryColor,
          disabledColor: _accentColor,
          brightness: Brightness.dark,
          shape: StadiumBorder(),
          secondaryLabelStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.all(0.0),
          deleteIconColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: _backgroundColor,
        errorColor: _secondaryColor,
        // toggleableActiveColor: _secondaryColor,
        toggleButtonsTheme: ToggleButtonsThemeData(
          selectedColor: _secondaryColor,
          disabledColor: Color(0xff7e7e7e),
        ),
        buttonColor: _primaryColor,
      );
}

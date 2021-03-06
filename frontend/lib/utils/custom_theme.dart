import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  final _backgroundColor = Color(0xfff2f6ff);
  final _primaryColor = Color(0xff4c60d2);
  final _secondaryColor = Color(0xfff48565);
  final _textColor = Color(0xff4c4c4c);
  final _accentColor = Color(0xffffd9cf);
  final _accentTextColor = Color(0xffe23300);
  final _boxShadow = BoxShadow(
    color: Color.fromRGBO(23, 21, 21, .03),
    blurRadius: 2.0,
    spreadRadius: 2.0,
    offset: Offset(0.0, 7.0),
  );
  final _inputBorderColor = Color(0xffb8b8b8);

  Color get backgroundColor => this._backgroundColor;
  Color get primaryColor => this._primaryColor;
  Color get secondaryColor => this._secondaryColor;
  Color get textColor => this._textColor;
  Color get accentColor => this._accentColor;
  Color get accentTextColor => this._accentTextColor;
  BoxShadow get boxShadow => this._boxShadow;

  ThemeData get appThemeData => ThemeData(
        primaryColor: _backgroundColor,
        accentColor: _accentColor,
        textTheme: TextTheme(
          headline6: GoogleFonts.roboto(
            color: _textColor,
          ),
          subtitle1: GoogleFonts.roboto(
            color: _textColor,
          ),
          subtitle2: GoogleFonts.roboto(
            color: _textColor,
          ),
          bodyText1: GoogleFonts.roboto(
            color: _textColor,
          ),
          bodyText2: GoogleFonts.roboto(
            color: _textColor,
          ),
          button: GoogleFonts.roboto(
              color: _textColor,
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400),
          caption: GoogleFonts.roboto(
            color: _textColor,
          ),
        ),
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
        primaryIconTheme: IconThemeData(color: _primaryColor),
        scaffoldBackgroundColor: _backgroundColor,
        errorColor: _secondaryColor,
        toggleableActiveColor: _secondaryColor,
        toggleButtonsTheme: ToggleButtonsThemeData(
          selectedColor: _secondaryColor,
          disabledColor: Color(0xff7e7e7e),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.white),
        ),
        buttonColor: _primaryColor,
        iconTheme: IconThemeData(color: _primaryColor),
        inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 1,
          errorStyle: TextStyle(
            color: _accentTextColor,
          ),
          hintStyle: TextStyle(color: Colors.grey[800]),
          fillColor: Colors.transparent,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _accentTextColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 9.0),
        ),
      );
}

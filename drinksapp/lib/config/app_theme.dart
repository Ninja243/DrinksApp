import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    buttonColor: Colors.lightBlue,
    accentColor: Colors.lightBlueAccent,
    iconTheme: IconThemeData(
      color: Colors.lightBlue,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.lightBlue,
      textTheme: TextTheme(
        headline5: GoogleFonts.montserrat(),
        headline6: GoogleFonts.montserrat(),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}

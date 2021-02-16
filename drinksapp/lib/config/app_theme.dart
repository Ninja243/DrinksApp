import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    buttonColor: Color(0xFF7F44FF),
    accentColor: Color(0xFF8E45E4),
    iconTheme: IconThemeData(
      color: Color(0xFF7F44FF),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0xFF6854f4),
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

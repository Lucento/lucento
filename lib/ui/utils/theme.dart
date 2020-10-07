import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucento/ui/utils/colors.dart';

ThemeData themeData = ThemeData(
  primaryColor: ThemeColors.primary,
  accentColor: ThemeColors.accent,
  fontFamily: GoogleFonts.poppins().fontFamily,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  ),
  buttonTheme: ButtonThemeData(
    // padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
    buttonColor: ThemeColors.accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readers_circle/utils/colors.dart';

final appTheme = ThemeData(
  primaryColor: CustomColors.primary,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
      color: Colors.black,
    ),
  ),
);

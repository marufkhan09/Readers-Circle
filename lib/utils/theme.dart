import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

ThemeData readersTheme(Brightness brightness) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: CustomColors.primary, // Set primary color
      onPrimary: Colors.white, // Text color on primary color
      surfaceTint: CustomColors.white,
    ),
    brightness: brightness,
    scaffoldBackgroundColor: CustomColors.white,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: CustomColors.primary,
      selectionColor: CustomColors.primary,
      selectionHandleColor: CustomColors.primary,
    ),
  );

  // Apply Poppins font using Google Fonts
  final textTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme);

  return baseTheme.copyWith(
    primaryColor: CustomColors.primary,
    scaffoldBackgroundColor: CustomColors.white,
    dialogTheme: DialogTheme(
      backgroundColor: CustomColors.white,
      titleTextStyle: textTheme.titleMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: textTheme.bodyMedium!.copyWith(
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: CustomColors.white, // AppBar background color
      titleTextStyle: textTheme.titleLarge!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: CustomColors.primary,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: CustomColors.primary, // Default button color
      textTheme: ButtonTextTheme.primary, // Text color on buttons
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.primary,
      foregroundColor: Colors.white,
    ),
    textTheme: textTheme, // Apply Poppins font to all text
  );
}

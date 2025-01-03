import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

ThemeData readersTheme(Brightness brightness) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: brightness == Brightness.dark
        ? const ColorScheme.dark(
            primary: CustomColors.primary,
            onPrimary: CustomColors.onPrimary,
            secondary: CustomColors.secondary,
            background: CustomColors.primary,
            surface: CustomColors.primary,
          )
        : const ColorScheme.light(
            primary: CustomColors.primary,
            onPrimary: CustomColors.onPrimary,
            secondary: CustomColors.secondary,
            background: CustomColors.white,
            surface: CustomColors.white,
          ),
    brightness: brightness,
    scaffoldBackgroundColor: CustomColors.white,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: CustomColors.primary,
      selectionColor: CustomColors.primary,
      selectionHandleColor: CustomColors.primary,
    ),
  );

  // Apply Google Fonts (Poppins)
  final textTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme);

  return baseTheme.copyWith(
    primaryColor: CustomColors.primary,
    scaffoldBackgroundColor: brightness == Brightness.dark
        ? CustomColors.primary
        : CustomColors.white,
    dialogTheme: DialogTheme(
      backgroundColor: brightness == Brightness.dark
          ? CustomColors.primary
          : CustomColors.white,
      titleTextStyle: textTheme.titleMedium!.copyWith(
        color: brightness == Brightness.dark ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: textTheme.bodyMedium!.copyWith(
        color: brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: CustomColors.primary,
      titleTextStyle: textTheme.titleLarge!.copyWith(
        color: CustomColors.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: CustomColors.primary,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: CustomColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: CustomColors.primary,
      foregroundColor: Colors.white,
    ),
    textTheme: textTheme,
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';
import 'typography.dart';

ThemeData darkTheme() => ThemeData(
      primaryColor: Palette.secondary,
      primarySwatch: Palette.secondary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Palette.scaffold,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Palette.secondary,
        secondary: Palette.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Palette.scaffold,
        elevation: 0,
        iconTheme: IconThemeData(color: Palette.white),
        titleTextStyle: Typo.titleLarge,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Palette.pureBlack,
        selectedItemColor: Palette.secondary,
        unselectedItemColor: Palette.white,
        selectedIconTheme: IconThemeData(color: Palette.secondary),
        elevation: 0,
      ),
      fontFamily: GoogleFonts.dmSans().fontFamily,
      textTheme: const TextTheme(
        displayLarge: Typo.displayLarge,
        displayMedium: Typo.displayMedium,
        displaySmall: Typo.displaySmall,
        headlineLarge: Typo.headlineLarge,
        headlineMedium: Typo.headlineMedium,
        headlineSmall: Typo.headlineSmall,
        titleLarge: Typo.titleLarge,
        titleMedium: Typo.titleMedium,
        titleSmall: Typo.titleSmall,
        bodyLarge: Typo.bodyLarge,
        bodyMedium: Typo.bodyMedium,
        bodySmall: Typo.bodySmall,
        labelLarge: Typo.labelLarge,
        labelSmall: Typo.labelSmall,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Palette.secondary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.secondary,
      ),
    );

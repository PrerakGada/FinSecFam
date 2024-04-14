import 'package:flutter/material.dart';

class Palette {
  // Create a Singleton Instance of Palette
  static final Palette _palette = Palette._internal();
  factory Palette() => _palette;
  Palette._internal();

  // Create a MaterialColor Swatch for Primary Color
  static const MaterialColor primary = MaterialColor(
    0xFF3A00E5,
    <int, Color>{
      50: Color(0xFF3A00E5),
      100: Color(0xFF3A00E5),
      200: Color(0xFF3A00E5),
      300: Color(0xFF3A00E5),
      400: Color(0xFF3A00E5),
      500: Color(0xFF3A00E5),
      600: Color(0xFF3A00E5),
      700: Color(0xFF3A00E5),
      800: Color(0xFF3A00E5),
      900: Color(0xFF3A00E5),
    },
  );


  // Create a MaterialColor Swatch for Secondary Color
  static const MaterialColor secondary = MaterialColor(
    0xFF3A00E5,
    <int, Color>{
      50: Color(0xFF3A00E5),
      100: Color(0xFF3A00E5),
      200: Color(0xFF3A00E5),
      300: Color(0xFF3A00E5),
      400: Color(0xFF3A00E5),
      500: Color(0xFF3A00E5),
      600: Color(0xFF3A00E5),
      700: Color(0xFF3A00E5),
      800: Color(0xFF3A00E5),
      900: Color(0xFF3A00E5),
    },
  );

  // Grey Shades
  static const Color pureBlack = Color(0xFF000000);
  static const Color black = Color(0xFF1F1F1F);
  static const Color dark = Color(0xFF626262);
  static const Color grey = Color(0xFF818479);
  static const Color light = Color(0xFFD2D2D2);
  static const Color white = Color(0xFFF7F7FF);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color scaffold = Color(0xFF181A1C);

  // Functions to get the color based on the theme mode
  Color textColor(context) =>
      Theme.of(context).brightness == Brightness.dark ? grey : black;
  Color hintColor(context) =>
      Theme.of(context).brightness == Brightness.dark ? light : dark;

  // Primary and Secondary Linear Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFA3B18A),
      Color(0xFFA3B18A),
    ],
  );
}

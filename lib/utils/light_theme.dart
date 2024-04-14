import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';
import 'utils.dart';

ThemeData lightTheme() => ThemeData(
      primaryColor: Color.fromRGBO(	52, 78, 65, 1),
      primarySwatch: Palette.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Palette.white,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Palette.primary,
        secondary: Palette.secondary,
      ),
      appBarTheme: AppBarTheme(
        color: Palette.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Palette.black),
        titleTextStyle: Typo.titleLarge.copyWith(color: Palette.black),
      ),
      fontFamily: GoogleFonts.montserrat().fontFamily,
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
    );

class ThemeHelper {
  BuildContext context;
  ThemeHelper({required this.context});
  InputDecoration textInputDecoration([
    String lableText = "",
    String hintText = "",
    Widget? suffixIcon,
    VoidCallback? onTapIcon,
  ]) {
    return InputDecoration(
      labelText: lableText,
      labelStyle: textField(),
      hintText: hintText,
      hintStyle: hintField(),
      errorMaxLines: 3,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      suffixIcon: Padding(
        padding: EdgeInsets.all(SizeConfig.getPercentSize(1)),
        child: IconButton(
          icon: suffixIcon ?? const Icon(null),
          color: Palette.black,
          onPressed: onTapIcon,
        ),
      ),
      filled: true,
      // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      contentPadding: EdgeInsets.only(
        top: SizeConfig.getPercentSize(0.5),
        left: SizeConfig.getPercentSize(4),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: Palette.primary,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: Palette.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// The [GoogleFonts] to be used as default.
  static get mainFont => GoogleFonts.karla();

  /// The [GoogleFonts] to be used on label and body.
  static get bodyFont => GoogleFonts.inter();

  static final theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    fontFamily: mainFont.fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: bodyFont,
    ),
    textTheme: TextTheme(
      labelLarge: bodyFont,
      labelMedium: bodyFont,
      labelSmall: bodyFont,
      bodyLarge: bodyFont,
      bodyMedium: bodyFont,
      bodySmall: bodyFont,
    ),
  );
}

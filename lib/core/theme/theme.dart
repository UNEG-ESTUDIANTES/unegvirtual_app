import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

/// The [GoogleFonts] to be used as default.
final _mainFont = GoogleFonts.karla();

/// The [GoogleFonts] to be used on label and body.
final _bodyFont = GoogleFonts.inter();

class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    fontFamily: _mainFont.fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _bodyFont,
    ),
    textTheme: TextTheme(
      labelLarge: _bodyFont,
      labelMedium: _bodyFont,
      labelSmall: _bodyFont,
      bodyLarge: _bodyFont,
      bodyMedium: _bodyFont,
      bodySmall: _bodyFont,
    ),
  );
}

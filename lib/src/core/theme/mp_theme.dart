import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPTheme {
  static ThemeData main({bool isDarkMode = false}) => isDarkMode
      ? ThemeData(
          primaryColor: MPColors.primary,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: MPTextStyle.darkTextTheme,
        )
      : ThemeData(
          primaryColor: MPColors.primary,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: MPTextStyle.mainTextTheme,
        );
}

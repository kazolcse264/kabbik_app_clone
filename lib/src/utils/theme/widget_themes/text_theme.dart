import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KTextTheme{
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.black87
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 24,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.white70
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 24,
    ),
  );
}
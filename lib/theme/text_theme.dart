import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
      headlineMedium: GoogleFonts.montserrat(
          color: Colors.black87, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.montserrat(
          color: Color.fromARGB(255, 40, 40, 40),
          fontSize: 20,
          fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.montserrat(
          fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w300),
      bodyMedium: GoogleFonts.montserrat(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      bodySmall: GoogleFonts.montserrat(
          color: Colors.black, fontWeight: FontWeight.bold));

  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
        color: Color.fromARGB(255, 235, 235, 235), fontWeight: FontWeight.w600),
    headlineSmall: GoogleFonts.montserrat(
        color: Colors.white60, fontSize: 20, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.montserrat(
        fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w300),
    bodyMedium: GoogleFonts.montserrat(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.montserrat(
        color: Colors.white, fontWeight: FontWeight.bold),
  );
}

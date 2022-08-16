import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
        primaryColor: primary,
        fontFamily: fontFamily,
        canvasColor: Colors.white,
        cardColor: Colors.grey[200],
        brightness: Brightness.light);
  }

  static ThemeData darkTheme() {
    return ThemeData(
        primaryColor: primary,
        fontFamily: fontFamily,
        canvasColor: Colors.black,
        cardColor: const Color.fromARGB(255, 30, 30, 30),
        brightness: Brightness.dark);
  }

  static Color lightGrey = Colors.grey[200]!;
  static Color primary = const Color(0xff1877F2);
  static Color secondary = const Color(0xff42B72A);
  static Color error = const Color(0xffc72c41);
  static Color success = Colors.green[500]!;
  static Color iconColor = Colors.grey[500]!;

  static String fontFamily = GoogleFonts.poppins().fontFamily!;
}

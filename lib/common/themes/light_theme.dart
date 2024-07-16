import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black, //black text
    focusColor: const Color.fromARGB(255, 8, 187, 101), //green heading
    shadowColor: Colors.grey[850], //subtitle color
    hintColor: Colors.grey[500], //textfield fill color
    primaryColorDark: Colors.white,
    hoverColor:
        const Color.fromARGB(255, 33, 72, 243), // Gradient Button Color 1
    dividerColor:
        const Color.fromARGB(255, 31, 184, 59), // Gradient Button Color 2

    //button themes later

    //appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    //text theme
    textTheme: TextTheme(
      titleMedium: GoogleFonts.ubuntu(
          fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black),
      titleLarge: GoogleFonts.chivo(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: const Color.fromARGB(255, 8, 187, 101)),
      labelSmall: TextStyle(
        color: Colors.grey[650],
        fontSize: 16,
      ), //subtitle
      displaySmall: const TextStyle(color: Colors.black), //Textfield Input Text
    ),

    //input field
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Colors.black, // Default label color
      ),
      hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontFamily: 'Varela' // Default hint text color
          ),
      prefixIconColor: Colors.black, // Icon color
      fillColor: Colors.grey[100], // Light fill color
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 10.0,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(GoogleFonts.spaceGrotesk(fontSize: 16)),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStatePropertyAll(Colors.black),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      padding: WidgetStatePropertyAll(
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0)),
      textStyle: WidgetStatePropertyAll(GoogleFonts.spaceGrotesk(fontSize: 14)),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStatePropertyAll(Colors.black),
    )));

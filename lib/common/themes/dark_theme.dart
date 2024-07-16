import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData customDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white, //black text
    focusColor: Colors.greenAccent, //green heading
    shadowColor: const Color.fromARGB(255, 187, 187, 187), //subtitle color
    hintColor: Colors.grey[850], //Textfield Fill Color
    hoverColor: Colors.blue, //Gradient Button Color 1
    dividerColor: Colors.green, //Gradient Button Color 2
    primaryColorDark: Colors.black,

    //appbar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

//Button Theme Later

    textTheme: TextTheme(
      titleMedium: GoogleFonts.ubuntu(
          fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
      titleLarge: GoogleFonts.chivo(
          fontWeight: FontWeight.bold, fontSize: 40, color: Colors.greenAccent),
      labelSmall: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ), //subtitle
      displaySmall: const TextStyle(color: Colors.white), //Textfield Input Text
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[850],
      hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontFamily: 'Varela'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
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
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      backgroundColor: WidgetStatePropertyAll(Colors.white),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0)),
      textStyle: WidgetStatePropertyAll(GoogleFonts.spaceGrotesk(fontSize: 14)),
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      backgroundColor: WidgetStatePropertyAll(Colors.white),
    )));

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Main colors
const Color accentColor = Color(0xfff2bb05);
const Color grey = Color(0xff66666E);
const Color imperialRed = Color(0xffF02D3A);

ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  accentColor: accentColor,
  dividerColor: grey,
  cardColor: imperialRed,
  textSelectionTheme:
      const TextSelectionThemeData(selectionHandleColor: accentColor),
  textTheme: GoogleFonts.montserratTextTheme(textTheme),
  //we use googleFont library to dynamically get fonts
);

const TextTheme textTheme = TextTheme(
  //Appbar title
  headline1: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: -1),
  //detailed title (name)
  headline2: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
  ),
  //detailed description
  bodyText1: TextStyle(
    fontSize: 16,
  ),
  //detailed directions
  bodyText2: TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: grey,
  ),
  //listTile title
  headline3:
      TextStyle(fontWeight: FontWeight.bold, wordSpacing: 2, fontSize: 16),
  //Listtile directions and distance
  headline4: TextStyle(
    fontStyle: FontStyle.italic,
    fontSize: 14,
  ),
  //ERROR message
  caption: TextStyle(
    fontSize: 18,
    letterSpacing: 0,
    wordSpacing: 2,
  ),
  //hint search box
  subtitle1: TextStyle(
    fontSize: 16,
    wordSpacing: 2,
    color: grey,
  ),
);

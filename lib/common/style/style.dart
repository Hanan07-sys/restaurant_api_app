import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Colors.white;
const Color secondaryColor = Color(0xFF141B21);
const Color listColor = Color(0xFFE3CAA5);
const Color foodColor = Colors.deepOrange;
const Color drinkColor = Colors.lightBlue;
const Color kRichBlack = Color(0xFF000814);
const Color kDavysGrey = Color(0xFF4B5358);


final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.deepOrange),
  headline3:
      GoogleFonts.merriweather(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.nunito(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
      color: Colors.black),
  headline5: GoogleFonts.nunito(
      fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
  headline6: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: secondaryColor),
  subtitle1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.black54),
  subtitle2: GoogleFonts.openSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.4,
      color: primaryColor),
  overline: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

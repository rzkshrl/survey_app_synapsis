import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

Color light = HexColor('#FFFFFF');
Color dark = HexColor('#121212');
Color blue = HexColor('#1FA0C9');
Color grey = HexColor('#757575');
Color grey2 = HexColor('#B9B9B9');
Color grey3 = HexColor('#D6E4EC');
Color grey4 = HexColor('#FBFBFB');
Color grey5 = HexColor('#D9D9D9');
Color grey6 = HexColor('#EEF6F9');
Color green = HexColor('#107C41');
Color error = HexColor('#FF0000');
Color errorBg = HexColor('#FF6C6C');

class SurveyAppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: light,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: light,
      iconTheme: IconThemeData(color: dark),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: light,
      ),
    ),
    brightness: Brightness.light,
    popupMenuTheme: PopupMenuThemeData(
      color: light,
      surfaceTintColor: Colors.transparent,
      textStyle:
          TextStyle(color: dark, fontSize: 10.sp, fontWeight: FontWeight.w400),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return blue;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return light;
        }
        return grey2.withOpacity(0.5);
      }),
      side: BorderSide(
        color: grey2,
      ),
    ),
    iconTheme: IconThemeData(
      color: dark,
    ),
    cardColor: light,
    textTheme: TextTheme(
      headlineLarge:
          GoogleFonts.inter(color: dark, fontWeight: FontWeight.w600),
      headlineMedium:
          GoogleFonts.inter(color: dark, fontWeight: FontWeight.w500),
      headlineSmall:
          GoogleFonts.inter(color: dark, fontWeight: FontWeight.w400),
      displayLarge: GoogleFonts.inter(color: dark, fontWeight: FontWeight.w600),
    ),
  );
}

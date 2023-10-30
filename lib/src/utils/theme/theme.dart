import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/utils/theme/widget_themes/text_theme.dart';

class KAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0x221622FF, <int, Color>{
      50: Color(0x1A1622FF),
      100: Color(0x331622FF),
      200: Color(0x4D1622FF),
      300: Color(0x661622FF),
      400: Color(0x801622FF),
      500: Color(0x991622FF),
      600: Color(0xB31622FF),
      700: Color(0xCC1622FF),
      800: Color(0xE61622FF),
      900: Color(0xFF1622FF),
    }),
    textTheme: KTextTheme.lightTextTheme,
  );
  static ThemeData dartTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(0x221622FF, <int, Color>{
      50: Color(0x1A1622FF),
      100: Color(0x331622FF),
      200: Color(0x4D1622FF),
      300: Color(0x661622FF),
      400: Color(0x801622FF),
      500: Color(0x991622FF),
      600: Color(0xB31622FF),
      700: Color(0xCC1622FF),
      800: Color(0xE61622FF),
      900: Color(0xFF1622FF),
    }),
    textTheme: KTextTheme.darkTextTheme,
  );
}

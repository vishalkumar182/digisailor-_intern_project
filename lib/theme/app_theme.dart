import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF007AFF),
    scaffoldBackgroundColor: const Color(0xFFD3E0EA),
    cardColor: const Color.fromARGB(255, 196, 191, 191),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1C2526)),
      bodyMedium: TextStyle(color: Color(0xFF1C2526)),
      titleLarge: TextStyle(
        color: Color(0xFF1C2526),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007AFF),
        foregroundColor: const Color.fromARGB(255, 198, 191, 191),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFFF9500)),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0A84FF),
    scaffoldBackgroundColor: const Color(0xFF1C2526),
    cardColor: const Color(0xFF2C2F33),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0A84FF),
        foregroundColor: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFFF9500)),
  );
}

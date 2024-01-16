import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black54,
      unselectedItemColor: Colors.grey,
      //selectedItemColor: Color(0xff1192cf),
      selectedItemColor: Colors.white,
      // backgroundColor: Color(0xff1192cf),
    ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      // backgroundColor: Color(0xff1192cf),
    ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  );
}

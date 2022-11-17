import 'package:flutter/material.dart';
enum AppTheme{
  darkTheme,
  lightTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.white,
      ),
    ),
    //
    //
    AppTheme.lightTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light, 
      backgroundColor: const Color(0xffe5e5e5),
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            Colors.black,
          ),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black
      ),
    ),
  };
}

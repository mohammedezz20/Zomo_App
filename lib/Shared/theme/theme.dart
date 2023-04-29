import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../styles/colores.dart';

ThemeData lighttheme = ThemeData(
  scaffoldBackgroundColor: lightBackgroundColor,
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: lightBackgroundColor,
          statusBarIconBrightness: Brightness.dark),
      color: lightBackgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: darkBackgroundColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: darkBackgroundColor,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey[500],
    ),
    labelMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black,

    ),
    labelLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),


);

ThemeData darktheme = ThemeData(
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: darkBackgroundColor,
            statusBarIconBrightness: Brightness.light),
        color: darkBackgroundColor,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
    textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: lightBackgroundColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: lightBackgroundColor,
        ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ), labelLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),

);

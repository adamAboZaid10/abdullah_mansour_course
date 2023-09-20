

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),

  ),


  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black,
    ),
  ),


  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),

  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.grey,
    ),
  ),

  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.grey,
  ),

);
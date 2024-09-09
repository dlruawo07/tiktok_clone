import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

final defaultTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: Typography.blackMountainView,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFFE9435A),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFFE9435A),
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: Sizes.size18,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey.shade50,
    elevation: 2,
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.grey.shade500,
    labelColor: Colors.black,
    indicatorColor: Colors.black,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: Typography.whiteMountainView,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: const Color(0xFFE9435A),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFFE9435A),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey.shade900,
    elevation: 2,
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.grey.shade500,
    labelColor: Colors.white,
    indicatorColor: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white,
  ),
);

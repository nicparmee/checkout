import 'package:flutter/material.dart';

ThemeData whiteTextTheme(ThemeData theme) => theme.copyWith(
  textTheme: theme.textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(textColor: Colors.white),
  inputDecorationTheme: theme.inputDecorationTheme.copyWith(
    labelStyle: const TextStyle(color: Colors.white),
    floatingLabelStyle: const TextStyle(color: Colors.white),
  ),
);

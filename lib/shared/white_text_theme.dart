import 'package:flutter/material.dart';

/// White text for pages drawn straight onto the grey background.
/// Chips and buttons keep their own colours.
ThemeData whiteTextTheme(ThemeData theme) => theme.copyWith(
  textTheme: theme.textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(textColor: Colors.white),
);

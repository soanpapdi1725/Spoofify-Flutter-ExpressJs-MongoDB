import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _borderStyles(Color borderColor) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 3),
        borderRadius: BorderRadius.circular(12),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _borderStyles(Pallete.borderColor),
      focusedBorder: _borderStyles(Pallete.gradient1),
      errorBorder: _borderStyles(Pallete.gradient3),
      focusedErrorBorder: _borderStyles(Pallete.gradient1),
    ),
  ); //ThemeData is class // copyWith is like change what you want and else will be the same
}

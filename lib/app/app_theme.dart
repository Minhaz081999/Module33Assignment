import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  // ---------------- Light Theme -----------------------
  static final ThemeData _lightThemeData = ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: _progressThemeData,
      // AppBar er Theme
      appBarTheme: _appBarTheme,
      // Text er Theme
      textTheme: _textTheme,
      // TextField er Theme
      inputDecorationTheme: _inputDecorationTheme,
      filledButtonTheme: _filledButtonTheme
  );
  // ---------------- Dark Theme -----------------------
  static final ThemeData _darkThemeData = ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      brightness: Brightness.dark,
      progressIndicatorTheme: _progressThemeData,
      // AppBar er Theme
      appBarTheme: _appBarTheme,
      // Text er Theme
      textTheme: _textTheme,
      // TextField er Theme
      inputDecorationTheme: _inputDecorationTheme,
      filledButtonTheme: _filledButtonTheme
  );

  static ProgressIndicatorThemeData get _progressThemeData =>
      ProgressIndicatorThemeData(color: AppColors.themeColor);

  static AppBarTheme get _appBarTheme => AppBarTheme(titleTextStyle: TextStyle(fontSize: 18, fontWeight: .bold, color: Colors.black54),);

  static TextTheme get _textTheme => TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: .bold
    )
  );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(

      hintStyle: TextStyle(color: Colors.grey),
      // when Active textField
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: AppColors.themeColor,
            width: 1
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Colors.red,
            width: 1
        ),
      ),

      contentPadding: .symmetric(horizontal: 16, vertical: 0)


  );

  static FilledButtonThemeData get _filledButtonTheme =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          // Button size
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          backgroundColor: AppColors.themeColor,
          padding: EdgeInsets.symmetric(vertical: 12),

        ),
      );

  static ThemeData get lightTheme => _lightThemeData;
  static ThemeData get darkTheme => _darkThemeData;
}

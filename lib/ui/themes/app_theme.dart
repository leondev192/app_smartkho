import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColor,
    ),
    fontFamily: 'Arima',

    // Cấu hình text theme
    textTheme: const TextTheme(
      bodyMedium: AppTextStyles.text4,
    ),

    // Cấu hình button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.whiteColor),
        textStyle: WidgetStateProperty.all(AppTextStyles.button),
      ),
    ),

    // Cấu hình AppBar
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
      titleTextStyle: AppTextStyles.textHeader.copyWith(
        fontSize: AppFonts.xxxLarge,
        color: AppColors.whiteColor,
      ),
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
    ),
  );
}

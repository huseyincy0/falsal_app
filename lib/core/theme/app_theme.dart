import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.purple,
  scaffoldBackgroundColor: AppColors.navy,
  textTheme: GoogleFonts.poppinsTextTheme(),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.gold,
    primary: AppColors.purple,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      elevation: 4,
      backgroundColor: AppColors.purple,
      foregroundColor: AppColors.gold,
    ),
  ),
); 
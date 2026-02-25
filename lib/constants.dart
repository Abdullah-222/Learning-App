import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF008D5E); // Approximate based on screenshot
  static const Color backgroundGray = Color(0xFFF5F7FA); // Light gray background
  static const Color white = Colors.white;
  
  // Restored Legacy Colors (to be refactored)
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6E6E6E);
  static const Color buttonGrey = Color(0xFFF3F4F6);
  static const Color lessonCardBorder = Color(0xFFE5E7EB);
  static const Color textLightGrey = Color(0xFF6B7280);
  static const Color sidebarText = Color(0xFF5F6368);
  static const Color sidebarSelected = Color(0xFFE8F0FE);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceHighlight = Color(0xFF2C2C2C);
  
  // Learn Page Colors
  static const Color recommendationBackground = Color(0xFFFFF9E6); // Light yellow/beige
  static const Color recommendationText = Color(0xFFB45309); // Orange/Brown for recommendation text
  static const Color activeLessonCardBorder = Color(0xFFE5E7EB);
}

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      surface: AppColors.white,
      onSurface: const Color(0xFF1A1A1A), // textDark
      surfaceContainerHighest: AppColors.backgroundGray, // scaffold background roughly
    ),
    scaffoldBackgroundColor: AppColors.backgroundGray,
    cardTheme: const CardThemeData(
        color: AppColors.white,
        surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: Color(0xFF1A1A1A)),
        bodySmall: TextStyle(color: Color(0xFF6E6E6E)), // textGrey
    ),
    dividerColor: const Color(0xFFE5E7EB),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      brightness: Brightness.dark,
      surface: AppColors.darkSurface,
      onSurface: AppColors.white,
      surfaceContainerHighest: AppColors.darkBackground,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardTheme: const CardThemeData(
        color: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
        headlineMedium: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: AppColors.white),
        bodySmall: TextStyle(color: Color(0xFFAAAAAA)),
    ),
    dividerColor: const Color(0xFF444444),
  );
}

class FunctionColor extends Color {
  const FunctionColor(super.value);
}

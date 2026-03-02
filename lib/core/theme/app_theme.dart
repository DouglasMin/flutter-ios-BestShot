import 'package:app_name/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: AppColors.primary,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: AppColors.primary,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.surfaceDark,
          foregroundColor: AppColors.textPrimaryDark,
          elevation: 0,
        ),
      );
}

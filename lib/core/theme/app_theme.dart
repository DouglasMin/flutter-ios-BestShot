import 'package:bestshot/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

abstract final class AppTheme {
  static CupertinoThemeData get light => const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        barBackgroundColor: AppColors.surface,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppColors.primary,
          textStyle: TextStyle(
            inherit: false,
            color: AppColors.textPrimary,
            fontFamily: '.SF Pro Text',
          ),
          navTitleTextStyle: TextStyle(
            inherit: false,
            color: AppColors.textPrimary,
            fontFamily: '.SF Pro Text',
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          navLargeTitleTextStyle: TextStyle(
            inherit: false,
            color: AppColors.textPrimary,
            fontFamily: '.SF Pro Display',
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  static CupertinoThemeData get dark => const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        barBackgroundColor: AppColors.surfaceDark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppColors.primary,
          textStyle: TextStyle(
            inherit: false,
            color: AppColors.textPrimaryDark,
            fontFamily: '.SF Pro Text',
          ),
          navTitleTextStyle: TextStyle(
            inherit: false,
            color: AppColors.textPrimaryDark,
            fontFamily: '.SF Pro Text',
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          navLargeTitleTextStyle: TextStyle(
            inherit: false,
            color: AppColors.textPrimaryDark,
            fontFamily: '.SF Pro Display',
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}

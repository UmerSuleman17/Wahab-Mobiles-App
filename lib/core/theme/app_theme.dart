import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.infoLight,
      onPrimaryContainer: AppColors.primaryNavy,
      secondary: AppColors.accentTeal,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.successLight,
      onSecondaryContainer: AppColors.primaryNavy,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.white,
    );

    const tabularFigures = <FontFeature>[FontFeature.tabularFigures()];

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 64,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(color: AppColors.lightGray),
        ),
        titleTextStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: const Color(0xFFEAF1FF),
        elevation: AppTokens.elevationSubtle,
        height: 76,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: isSelected ? 23 : 21,
            color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
          );
        }),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: Color(0xFFEAF1FF),
        minWidth: 80,
        minExtendedWidth: 200,
        selectedIconTheme: IconThemeData(color: AppColors.primaryBlue),
        unselectedIconTheme: IconThemeData(color: AppColors.textSecondary),
        selectedLabelTextStyle: TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(color: AppColors.textSecondary),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: AppTokens.elevationSubtle,
        shadowColor: AppColors.shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
          side: const BorderSide(color: AppColors.lightGray),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppTokens.space4,
          vertical: AppTokens.space2,
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space4,
          vertical: AppTokens.space2,
        ),
        minLeadingWidth: 40,
        iconColor: AppColors.textSecondary,
        titleTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        subtitleTextStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.lightGray,
          disabledForegroundColor: AppColors.textSecondary,
          elevation: 0,
          minimumSize: const Size(48, AppTokens.minimumTapTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          side: const BorderSide(color: AppColors.lightGray),
          minimumSize: const Size(48, AppTokens.minimumTapTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          minimumSize: const Size(48, AppTokens.minimumTapTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.space4),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space4,
          vertical: AppTokens.space3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          borderSide:
              const BorderSide(color: AppColors.primaryBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textHint),
        errorStyle: const TextStyle(color: AppColors.error),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: AppTokens.elevationFloating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.background,
        selectedColor: AppColors.infoLight,
        labelStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space2,
          vertical: AppTokens.space1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusPill),
          side: const BorderSide(color: AppColors.lightGray),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightGray,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTokens.radiusExtraLarge),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryNavy,
        contentTextStyle: const TextStyle(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
        ),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          fontFeatures: tabularFigures,
        ),
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          fontFeatures: tabularFigures,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          fontFeatures: tabularFigures,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBlue,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color divider = Color(0xFFE8E8E8);
  static const Color border = Color(0xFFF0F0F0);
  static const Color accent = Color(0xFF2D2D2D);
  static const Color accentSubtle = Color(0xFFF5F5F5);
  static const Color availableGreen = Color(0xFF34A853);
  static const Color availableGreenBg = Color(0xFFE8F5E9);
  static const Color takenGrey = Color(0xFFD9D9D9);
  static const Color shimmerBase = Color(0xFFEEEEEE);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color availableAmber = Color(0xFFF9A825);
}

class AppTheme {
  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF2D2D2D),
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
    );

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.accentSubtle,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textTertiary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.textPrimary);
          }
          return const IconThemeData(color: AppColors.textTertiary);
        }),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      // Display styles — DM Sans
      displayLarge: GoogleFonts.dmSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.dmSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.25,
      ),
      // Heading styles — DM Sans
      headlineLarge: GoogleFonts.dmSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.dmSans(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.35,
      ),
      headlineSmall: GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      // Body styles — Inter
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
      // Label/caption styles — Inter
      labelLarge: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 1.0,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
        height: 1.4,
      ),
    ).apply(
      // Ensure unused styles still use Inter
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );
  }
}

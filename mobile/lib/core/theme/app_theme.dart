import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData light() {
    return _buildTheme(Brightness.light);
  }

  static ThemeData dark() {
    return _buildTheme(Brightness.dark);
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      onSurface: isDark ? AppColors.darkTextMain : AppColors.lightTextMain,
      outline: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    );

    final baseTextTheme = GoogleFonts.interTextTheme(
      isDark ? _darkTextTheme : _lightTextTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      textTheme: baseTextTheme,
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outline, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }

  static final _lightTextTheme = const TextTheme(
    displayLarge: TextStyle(color: AppColors.lightTextMain),
    displayMedium: TextStyle(color: AppColors.lightTextMain),
    bodyLarge: TextStyle(color: AppColors.lightTextMain),
    bodyMedium: TextStyle(color: AppColors.lightTextMain),
    labelLarge: TextStyle(color: AppColors.lightTextMuted),
  );

  static final _darkTextTheme = const TextTheme(
    displayLarge: TextStyle(color: AppColors.darkTextMain),
    displayMedium: TextStyle(color: AppColors.darkTextMain),
    bodyLarge: TextStyle(color: AppColors.darkTextMain),
    bodyMedium: TextStyle(color: AppColors.darkTextMain),
    labelLarge: TextStyle(color: AppColors.darkTextMuted),
  );
}

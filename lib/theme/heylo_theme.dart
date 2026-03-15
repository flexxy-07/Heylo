import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/theme/app_pallete.dart';

class HeyloTheme {
  // Theme Data: Atmospheric Intelligence
  static ThemeData get darkTheme {
    final textTheme = _buildTextTheme();
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppPallete.background,
      primaryColor: AppPallete.primary,
      
      colorScheme: const ColorScheme.dark(
        primary: AppPallete.primary,
        onPrimary: AppPallete.onPrimary,
        primaryContainer: AppPallete.primaryContainer,
        onPrimaryContainer: AppPallete.onPrimaryContainer,
        secondary: AppPallete.secondary,
        onSecondary: AppPallete.onSecondary,
        secondaryContainer: AppPallete.secondaryContainer,
        tertiary: AppPallete.tertiary,
        onTertiary: AppPallete.onTertiary,
        surface: AppPallete.surface,
        onSurface: AppPallete.onSurface,
        surfaceVariant: AppPallete.surfaceVariant,
        onSurfaceVariant: AppPallete.onSurfaceVariant,
        error: AppPallete.error,
        onError: AppPallete.onError,
        outline: AppPallete.outline,
        outlineVariant: AppPallete.outlineVariant,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: AppPallete.foreground,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: AppPallete.primary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.primary,
          foregroundColor: AppPallete.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: const StadiumBorder(), // "Full" roundedness for aerodynamic look
          textStyle: GoogleFonts.inter(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
          ),
        ).copyWith(
          shadowColor: MaterialStateProperty.all(AppPallete.ambientGlow(AppPallete.primary)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPallete.primary,
          side: BorderSide(
            color: AppPallete.outlineVariant.withOpacity(0.15), // Ghost Border Rule
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.inter(
            fontSize: 16, 
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textTheme: textTheme,

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPallete.surfaceContainerLowest,
        hintStyle: GoogleFonts.inter(color: AppPallete.onSurfaceVariant),
        labelStyle: GoogleFonts.inter(color: AppPallete.primary),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24), // xl roundedness
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppPallete.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppPallete.error, width: 1),
        ),
      ),

      cardTheme: CardThemeData(
        color: AppPallete.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // xl roundedness
        ),
      ),

      dividerTheme: DividerThemeData(
        color: AppPallete.background, // Use 1px gap revealing background
        thickness: 1,
        space: 1,
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        color: AppPallete.onSurface,
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        color: AppPallete.onSurface,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        color: AppPallete.onSurface,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppPallete.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.inter(
        color: AppPallete.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(
        color: AppPallete.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppPallete.onSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: GoogleFonts.inter(
        color: AppPallete.onSurfaceVariant,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5, // HUD effect
      ),
    );
  }
}

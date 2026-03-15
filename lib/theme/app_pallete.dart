import 'package:flutter/material.dart';

class AppPallete {
  // Brand Colors
  static const Color primary = Color(0xFF49F6D8); // neon pulse
  static const Color primaryContainer = Color(0xFF06D9BC);
  static const Color primaryDim = Color(0xFF31E7CA);
  
  static const Color secondary = Color(0xFF3CFBF0);
  static const Color secondaryContainer = Color(0xFF006A65);
  static const Color secondaryDim = Color(0xFF1BEDE2);
  
  static const Color tertiary = Color(0xFF65D0FF);
  static const Color tertiaryContainer = Color(0xFF0EC4FE);

  // Surface Philosophy: Deep Luminous Void
  static const Color background = Color(0xFF0B0F0F);
  static const Color surface = Color(0xFF0B0F0F);
  
  // Surface Hierarchy
  static const Color surfaceContainerLowest = Color(0xFF000000);
  static const Color surfaceContainerLow = Color(0xFF101414);
  static const Color surfaceContainer = Color(0xFF161A1A);
  static const Color surfaceContainerHigh = Color(0xFF1B2121);
  static const Color surfaceContainerHighest = Color(0xFF212727);
  static const Color surfaceBright = Color(0xFF272D2D);
  static const Color surfaceVariant = Color(0xFF212727);

  // Foreground / Text (Inter)
  static const Color foreground = Color(0xFFFAFDFC);
  static const Color onBackground = Color(0xFFFAFDFC);
  static const Color onSurface = Color(0xFFFAFDFC);
  static const Color onSurfaceVariant = Color(0xFFA8ACAB);
  
  static const Color onPrimary = Color(0xFF00594C);
  static const Color onPrimaryContainer = Color(0xFF00453B);
  static const Color onSecondary = Color(0xFF005C57);
  static const Color onTertiary = Color(0xFF00445A);

  // Semantic & Feedback
  static const Color error = Color(0xFFFF716C);
  static const Color onError = Color(0xFF490006);
  static const Color errorContainer = Color(0xFF9F0519);
  
  static const Color outline = Color(0xFF727676);
  static const Color outlineVariant = Color(0xFF454948); // Use at 15% opacity for ghost borders

  // Multi-tier Shadows (Ambient Glow)
  static Color ambientGlow(Color color) => color.withOpacity(0.04);

  // Signature Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryContainer],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0x33212727), // surface-variant at 20%
      Color(0x1A212727), // surface-variant at 10%
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

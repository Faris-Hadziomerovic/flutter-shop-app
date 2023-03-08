import 'package:flutter/material.dart';

/// Class that contains colors used throughout the app.
class AppColors {
  /// The primary color of the app
  static const primaryColor = Colors.red;

  /// The secondary color of the app
  static const secondaryColor = Colors.amber;

  /// The color of translucent overlays.
  /// To be used with snackBar and toast widgets as their background.
  static const overlayColor = Colors.black54;

  /// A <code>ColorScheme</code> generated for a light app theme.
  /// Uses the global primary and secondary color in the seed.
  static ColorScheme get colorScheme => ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
      );
}

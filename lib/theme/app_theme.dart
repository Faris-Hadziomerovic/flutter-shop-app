import 'package:flutter/material.dart';

import './app_colors.dart';
import './app_shapes.dart';

/// Class that contains the themes used throughout the app.
class AppTheme {
  /// The <code>ThemeData</code> that's used to configure
  /// the light mode app theme.
  static ThemeData get appThemeData => ThemeData(
        colorScheme: AppColors.colorScheme,
        textTheme: const TextTheme(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.colorScheme.primary,
          splashColor: AppColors.colorScheme.secondary,
          foregroundColor: AppColors.colorScheme.onPrimary,
          iconSize: 30,
          extendedTextStyle: const TextStyle(
            fontSize: 17,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          elevation: 0,
          backgroundColor: AppColors.overlayColor,
          shape: AppShapes.roundedShapeTopRadius10,
        ),
        cardTheme: const CardTheme(
          elevation: 5,
          shape: AppShapes.roundedShapeRadius15,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(AppShapes.roundedShapeRadius10),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: const MaterialStatePropertyAll(AppShapes.roundedShapeRadius10),
            side: MaterialStatePropertyAll(
              BorderSide(
                width: 1.2,
                color: AppColors.colorScheme.primary,
              ),
            ),
          ),
        ),
      );
}

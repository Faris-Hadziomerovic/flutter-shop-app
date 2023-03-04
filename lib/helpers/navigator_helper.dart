import 'package:flutter/material.dart';

import '../screens/products_overview_screen.dart';

class NavigatorHelper {
  static String get homeScreenRoute => ProductsOverviewScreen.routeName;

  /// Used with <i><b>WillPopScope</b></i> widget to redirect to the home page instead of exiting the app.
  static Future<bool> returnToHomeScreen(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
      homeScreenRoute,
      (route) => false,
    );

    return true;
  }

  /// Used with <i><b>WillPopScope</b></i> widget to prevent the user from exiting the app accidentally. <br/>
  /// Shows an <i><b>AlertDialog</b></i> with <code>Stay</code> and <code>Leave</code> options, dismissing
  /// the dialog will be treated as pressing <code>Stay</code>.
  static Future<bool> showExitAppDialog(BuildContext context) async {
    return await showDialog<bool>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('If you exit the app, all unsaved progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Stay'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Leave'),
                  ),
                ],
              );
            }) ??
        false;
  }
}

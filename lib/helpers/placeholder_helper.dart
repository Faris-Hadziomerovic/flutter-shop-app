import 'package:flutter/material.dart';

class PlaceholderHelper {
  static Widget showPlaceholderText(
    BuildContext context, {
    required String text,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20.0),
  }) {
    return Center(
      child: Padding(
        padding: padding,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

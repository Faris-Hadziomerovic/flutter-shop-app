import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/font_family.dart';
import '../../constants/placeholder_messages.dart';

class WorkInProgressPlaceholder extends StatelessWidget {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final BorderRadiusGeometry? borderRadius;

  const WorkInProgressPlaceholder({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    final fgColor = foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
    final borderRadiusGeometry = borderRadius ?? BorderRadius.circular(5);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 40.0,
      ),
      transform: Matrix4.rotationZ(-10 * pi / 180)..translate(-20.0, 40),
      decoration: BoxDecoration(
        borderRadius: borderRadiusGeometry,
        color: bgColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: FittedBox(
        child: Text(
          PlaceholderMessages.workInProgress,
          style: TextStyle(
            color: fgColor,
            fontSize: 35,
            fontFamily: FontFamily.carpalTunnel,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NotificationsBadge extends StatelessWidget {
  final Widget child;
  final int quantity;
  final Color? color;

  const NotificationsBadge({
    super.key,
    required this.child,
    this.quantity = 0,
    this.color,
  }) : assert(quantity >= 0);

  String get label {
    if (quantity < 100) {
      return '$quantity';
    } else {
      return '😎';
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? Theme.of(context).colorScheme.secondary;
    final fontColor = Theme.of(context).colorScheme.onSecondary;
    final shouldShowBadge = quantity > 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (shouldShowBadge)
          Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircleAvatar(
                backgroundColor: badgeColor,
                child: FittedBox(
                  child: Text(
                    label,
                    style: TextStyle(color: fontColor, fontSize: 12),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}

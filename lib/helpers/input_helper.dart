import 'package:flutter/material.dart';

class InputHelper {
  static OutlineInputBorder createOutlineInputBorder({
    Color? color = Colors.transparent,
    double width = 1,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10)),
  }) {
    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: color ?? Colors.black54,
        width: width,
      ),
    );
  }

  static InputDecoration createInputDecoration(
    BuildContext context, {
    String? labelText,
    String? prefixText,
    String? suffixText,
    Color? focusedColor,
    Color? enabledColor,
    Color? disabledColor = Colors.blueGrey,
    Color? errorColor = Colors.red,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixText: prefixText,
      suffixText: suffixText,
      border: createOutlineInputBorder(),
      focusedBorder: createOutlineInputBorder(
        color: focusedColor ?? Theme.of(context).colorScheme.primary,
        width: 2.0,
      ),
      enabledBorder: createOutlineInputBorder(
        color: enabledColor ?? Theme.of(context).primaryColor,
        width: 0.8,
      ),
      disabledBorder: createOutlineInputBorder(color: disabledColor),
      errorBorder: createOutlineInputBorder(color: errorColor),
    );
  }
}

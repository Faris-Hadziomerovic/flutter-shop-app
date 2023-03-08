import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/theme/app_colors.dart';

import '../constants/exception_messages.dart';

class HelperToast {
  static Color toastBackgroundColor = AppColors.overlayColor;

  static void show({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: toastBackgroundColor,
    );
  }

  static void showNotImplementedToast() {
    Fluttertoast.showToast(
      msg: ExceptionMessages.notImplemented,
      backgroundColor: toastBackgroundColor,
    );
  }

  static void showStringToNumberParsingErrorToast() {
    Fluttertoast.showToast(
      msg: ExceptionMessages.failedParseToNumber,
      backgroundColor: toastBackgroundColor,
    );
  }
}

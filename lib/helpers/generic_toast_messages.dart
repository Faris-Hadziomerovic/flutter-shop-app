import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/exception_messages.dart';

class HelperToast {
  static void showNotImplementedToast() {
    Fluttertoast.showToast(
      msg: ExceptionMessages.notImplemented,
      backgroundColor: Colors.black54,
    );
  }

  static void showStringToNumberParsingErrorToast() {
    Fluttertoast.showToast(
      msg: ExceptionMessages.failedParseToNumber,
      backgroundColor: Colors.black54,
    );
  }
}

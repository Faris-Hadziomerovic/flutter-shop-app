import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/exception_message_constants.dart';

class HelperToast {
  static void showNotImplementedToast() {
    Fluttertoast.showToast(
      msg: ExceptionMessageConstants.notImplemented,
      backgroundColor: Colors.black54,
    );
  }

  static void showStringToNumberParsingErrorToast() {
    Fluttertoast.showToast(
      msg: ExceptionMessageConstants.failedParseToNumber,
      backgroundColor: Colors.black54,
    );
  }
}

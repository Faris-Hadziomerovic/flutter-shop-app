import 'dart:io';

import 'package:http/http.dart';

import '../constants/api_constants.dart';

class HttpHelper {
  static Uri generateFirebaseURL({required String endpoint}) {
    return Uri.https(
      ApiConstants.firebaseAPI,
      endpoint + ApiConstants.firebaseSuffix,
    );
  }

  static void throwIfNot200(Response response, {Uri? url}) {
    if (response.statusCode != 200) {
      throw HttpException(response.body, uri: url);
    }
  }
}

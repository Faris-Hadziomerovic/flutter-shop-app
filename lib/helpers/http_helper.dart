import 'dart:io';

import 'package:http/http.dart';

import '../constants/api_constants.dart';

class HttpHelper {
  static Uri generateFirebaseURL({required String endpoint}) {
    final path = ApiConstants.databasePath + endpoint + ApiConstants.firebaseSuffix;

    return Uri.https(ApiConstants.firebaseAPI, path);
  }

  static void throwIfNot200(Response response, {Uri? url}) {
    if (response.statusCode != 200) {
      throw HttpException(response.body, uri: url);
    }
  }
}

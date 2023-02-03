class AddProductException implements Exception {
  String get message =>
      "Something went wrong while uploading the data to the server. Please make sure that you are connected to the internet.";

  @override
  String toString() {
    return message;
  }
}

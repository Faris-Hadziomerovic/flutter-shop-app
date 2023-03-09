class AddItemException implements Exception {
  String get message =>
      'Something went wrong while adding the data to the server. Please make sure that you are connected to the internet.';

  @override
  String toString() {
    return message;
  }
}

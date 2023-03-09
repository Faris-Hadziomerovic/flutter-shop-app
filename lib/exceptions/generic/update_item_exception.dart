class UpdateItemException implements Exception {
  String get message =>
      'Something went wrong while updating the data on the server. Please make sure that you are connected to the internet.';

  @override
  String toString() {
    return message;
  }
}

class RemoveItemException implements Exception {
  String get message =>
      "Something went wrong while removing the data from the server. Please make sure that you are connected to the internet.";

  @override
  String toString() {
    return message;
  }
}

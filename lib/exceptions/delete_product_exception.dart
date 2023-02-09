class DeleteProductException implements Exception {
  String get message =>
      "Something went wrong while deleting the data from the server. Please make sure that you are connected to the internet.";

  @override
  String toString() {
    return message;
  }
}

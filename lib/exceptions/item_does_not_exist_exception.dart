class ItemDoesNotExistException implements Exception {
  String get message => "The requested item does not exist.";

  @override
  String toString() {
    return message;
  }
}

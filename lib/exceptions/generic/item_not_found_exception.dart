class ItemNotFoundException implements Exception {
  String get message => 'Requested item does not exist.';

  @override
  String toString() {
    return message;
  }
}

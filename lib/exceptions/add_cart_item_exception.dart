class AddCartItemException implements Exception {
  String get message => "One of the arguments for the added item was invalid.";

  @override
  String toString() {
    return message;
  }
}

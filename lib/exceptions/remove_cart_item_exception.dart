class RemoveCartItemException implements Exception {
  final String message;

  RemoveCartItemException({
    this.message = "One of the arguments for the removed item was invalid.",
  });

  @override
  String toString() {
    return message;
  }
}

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  String toString() {
    return '''{
      id: $id, 
      name: $name, 
      price: $price, 
      quantity: $quantity, \n}''';
  }
}

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
    return '{ \n\t id: $id, \n\t name: $name, \n\t price: $price, \n\t quantity: $quantity, \n}';
  }
}

class CartItem {
  final String id;
  late final String name;
  late final double price;
  late int quantity;

  bool get isValid => id.isNotEmpty && name.isNotEmpty && price >= 0.00 && quantity >= 1;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartItem.fromMap({required this.id, required Map<String, dynamic> cartData}) {
    name = cartData['name'] as String;
    price = (cartData['price'] as num).toDouble();
    quantity = cartData['quantity'] as int;
  }

  Map<String, Object> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return '''{
      id: $id, 
      name: $name, 
      price: $price, 
      quantity: $quantity, \n}''';
  }
}

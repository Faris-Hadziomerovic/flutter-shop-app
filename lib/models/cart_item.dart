class CartItem {
  final String id;
  late final String name;
  late final double price;
  late int quantity;

  bool get isValid => id.isNotEmpty && name.isNotEmpty && price >= 0.00 && quantity >= 1;

  static String get idKey => 'id';
  static String get nameKey => 'name';
  static String get priceKey => 'price';
  static String get quantityKey => 'quantity';

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartItem.fromMap({required this.id, required Map<String, dynamic> cartData}) {
    name = cartData[nameKey] as String;
    price = (cartData[priceKey] as num).toDouble();
    quantity = cartData[quantityKey] as int;
  }

  Map<String, Object> toMap({bool includeId = false}) {
    return {
      if (includeId) idKey: id,
      nameKey: name,
      priceKey: price,
      quantityKey: quantity,
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

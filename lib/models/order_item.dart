import '../models/cart_item.dart';

class OrderItem {
  final String id;
  late final double amount;
  late final List<CartItem> products;
  late final DateTime dateTime;

  static String get idKey => 'id';
  static String get amountKey => 'amount';
  static String get dateTimeKey => 'dateTime';
  static String get productsKey => 'products';

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  OrderItem.fromMap({required this.id, required Map<String, dynamic> orderData}) {
    final orderedProducts = (orderData[productsKey] as List<dynamic>)
        .map(
          (orderedProductsMap) => CartItem.fromMap(
            id: orderedProductsMap[CartItem.idKey] as String,
            cartData: orderedProductsMap,
          ),
        )
        .toList();

    products = orderedProducts;
    amount = (orderData[amountKey] as num).toDouble();
    dateTime = DateTime.parse(orderData[dateTimeKey]);
  }

  Map<String, Object> toMap() {
    return {
      amountKey: amount,
      dateTimeKey: dateTime.toIso8601String(),
      productsKey: [...products.map((cartItem) => cartItem.toMap(includeId: true))],
    };
  }

  @override
  String toString() {
    return '''{
      id: $id, 
      amount: $amount, 
      dateTime: $dateTime, 
      products: $products, \n}''';
  }
}

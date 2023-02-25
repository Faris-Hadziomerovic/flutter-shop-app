import '../models/cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  @override
  String toString() {
    return '''{
      id: $id, 
      amount: $amount, 
      dateTime: $dateTime, 
      products: $products, \n}''';
  }
}

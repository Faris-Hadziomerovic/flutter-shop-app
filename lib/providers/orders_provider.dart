import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrders(List<CartItem> cartItems, double total) {
    _orders.add(
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartItems,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}

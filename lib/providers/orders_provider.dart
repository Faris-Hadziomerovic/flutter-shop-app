import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../constants/endpoints.dart';
import '../exceptions/order/add_product_exception.dart';
import '../exceptions/order/fetch_products_exception.dart';
import '../helpers/http_helper.dart';
import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _localOrders = [];

  List<OrderItem> get orders => [..._localOrders];

  Future<void> fetchAndSetAsync() async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.orders);

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      _localOrders.clear();

      if (responseData == null) return;

      responseData.forEach((itemId, orderData) {
        final orderItem = OrderItem.fromMap(id: itemId, orderData: orderData);
        _localOrders.add(orderItem);
      });

      notifyListeners();
    } on Exception {
      throw FetchOrdersException();
    }
  }

  Future<void> addAsync({required List<CartItem> cartItems, required double total}) async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.orders);

    try {
      final creationDateTime = DateTime.now();

      final orderMap = OrderItem(
        id: '',
        amount: total,
        products: cartItems,
        dateTime: creationDateTime,
      ).toMap();

      final response = await http.post(url, body: jsonEncode(orderMap));

      HttpHelper.throwIfNot200(response);

      final id = jsonDecode(response.body)[ApiConstants.firebasePostResponseIdKey];

      final newOrder = OrderItem(
        id: id,
        amount: total,
        products: cartItems,
        dateTime: creationDateTime,
      );

      _localOrders.add(newOrder);

      notifyListeners();
    } on Exception {
      throw AddOrderException();
    }
  }
}

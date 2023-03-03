import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';
import '../exceptions/cart/add_cart_item_exception.dart';
import '../exceptions/cart/clear_cart_exception.dart';
import '../exceptions/cart/fetch_cart_exception.dart';
import '../exceptions/cart/remove_cart_item_exception.dart';
import '../exceptions/cart/update_quantity_exception.dart';
import '../exceptions/generic/item_not_found_exception.dart';
import '../helpers/http_helper.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  final List<CartItem> _localCart = [];

  List<CartItem> get cart => [..._localCart];

  bool get cartIsEmpty => _localCart.isEmpty;

  bool get cartIsNotEmpty => _localCart.isNotEmpty;

  int get itemCount {
    int quantity = 0;

    for (var item in _localCart) {
      quantity += item.quantity;
    }

    return quantity;
  }

  double get totalAmount {
    double totalPrice = 0.00;

    for (var item in _localCart) {
      totalPrice += item.price * item.quantity;
    }

    return totalPrice;
  }

  Future<void> fetchAndSetAsync() async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.cart);

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      _localCart.clear();

      if (responseData == null) return;

      responseData.forEach((itemId, cartData) {
        final cartItem = CartItem.fromMap(id: itemId, cartData: cartData);
        _localCart.add(cartItem);
      });

      notifyListeners();
    } on Exception {
      throw FetchCartException();
    }
  }

  Future<void> addAsync({required CartItem cartItem}) async {
    if (!cartItem.isValid) {
      throw ArgumentError.value(cartItem);
    }

    // get real number from server
    final existingItem = _localCart.firstWhereOrNull((item) => item.id == cartItem.id);

    if (existingItem == null) {
      await _addAsync(cartItem: cartItem);
    } else {
      await _updateQuantityAsync(
        id: cartItem.id,
        quantity: existingItem.quantity + cartItem.quantity,
      );
    }
  }

  Future<void> removeAsync({required String id}) async {
    final existingItem = _localCart.firstWhereOrNull((item) => item.id == id);

    if (existingItem == null) {
      throw ItemNotFoundException();
    }

    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.cart}/$id');

    try {
      final response = await http.delete(url);

      HttpHelper.throwIfNot200(response);

      _localCart.remove(existingItem);

      notifyListeners();
    } on Exception {
      throw ClearCartException();
    }
  }

  Future<void> decreaseQuantityAsync({required String id, int decreaseBy = 1}) async {
    try {
      final quantity = await _getQuantityByIdAsync(id: id);

      if (decreaseBy < quantity) {
        await _updateQuantityAsync(id: id, quantity: quantity - decreaseBy);
      } else {
        await removeAsync(id: id);
      }
    } on Exception {
      throw RemoveCartItemException();
    }
  }

  Future<void> clearAsync() async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.cart);

    try {
      final response = await http.delete(url);

      HttpHelper.throwIfNot200(response);

      _localCart.clear();

      notifyListeners();
    } on Exception {
      throw ClearCartException();
    }
  }

  Future<void> _addAsync({required CartItem cartItem}) async {
    final url = HttpHelper.generateFirebaseURL(
      endpoint: '${Endpoints.cart}/${cartItem.id}',
    );

    try {
      final response = await http.put(url, body: jsonEncode(cartItem.toMap()));

      HttpHelper.throwIfNot200(response);

      final newItem = CartItem(
        id: cartItem.id,
        name: cartItem.name,
        price: cartItem.price,
        quantity: cartItem.quantity,
      );

      _localCart.add(newItem);

      notifyListeners();
    } on Exception {
      throw AddCartItemException();
    }
  }

  Future<void> _updateQuantityAsync({required String id, required int quantity}) async {
    final existingItem = _localCart.firstWhereOrNull((item) => item.id == id);

    if (existingItem == null) {
      throw ItemNotFoundException();
    }

    final url = HttpHelper.generateFirebaseURL(
      endpoint: '${Endpoints.cart}/$id/${CartItem.quantityKey}',
    );

    try {
      final response = await http.put(url, body: jsonEncode(quantity));

      HttpHelper.throwIfNot200(response);

      existingItem.quantity = quantity;

      notifyListeners();
    } on Exception {
      throw UpdateQuantityException();
    }
  }

  Future<int> _getQuantityByIdAsync({required String id}) async {
    final existingItem = _localCart.firstWhereOrNull((item) => item.id == id);

    if (existingItem == null) {
      throw ItemNotFoundException();
    }

    final url = HttpHelper.generateFirebaseURL(
      endpoint: '${Endpoints.cart}/$id/${CartItem.quantityKey}',
    );

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      int quantity = (jsonDecode(response.body) as num).toInt();

      return quantity;
    } on Exception {
      throw FetchCartException();
    }
  }
}

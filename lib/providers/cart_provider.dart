import 'package:flutter/material.dart';
import 'package:shop_app/exceptions/item_does_not_exist_exception.dart';

import '../constants/exception_message_constants.dart';
import '../exceptions/remove_cart_item_exception.dart';
import '../exceptions/add_cart_item_exception.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _cart = {};

  Map<String, CartItem> get cart => {..._cart};

  bool get cartIsEmpty => _cart.isEmpty;

  bool get cartIsNotEmpty => _cart.isNotEmpty;

  int get itemCount {
    int quantity = 0;

    for (var item in _cart.values) {
      quantity += item.quantity;
    }

    return quantity;
  }

  double get totalAmount {
    double total = 0.00;

    for (var item in _cart.values) {
      total += item.price * item.quantity;
    }

    return total;
  }

  int getItemQuantityCount(String itemId) {
    if (!_cart.containsKey(itemId)) {
      throw ItemDoesNotExistException();
    }

    return _cart[itemId]!.quantity;
  }

  void addItem({
    required String itemId,
    required String title,
    required double price,
    int quantity = 1,
  }) {
    if (itemId.isEmpty || title.isEmpty || price < 0.00 || quantity < 1) {
      throw AddCartItemException();
    }

    if (_cart.containsKey(itemId)) {
      // _cart.update(
      //   itemId,
      //   (existingItem) => CartItem(
      //     id: existingItem.id,
      //     name: existingItem.name,
      //     price: existingItem.price,
      //     quantity: existingItem.quantity + quantity,
      //   ),
      // );

      // changed the CartItem quantity to a non-final property
      _cart[itemId]?.quantity += quantity;
    } else {
      _cart.putIfAbsent(
        itemId,
        () => CartItem(
          id: itemId,
          name: title,
          price: price,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  void decreaseItemQuantity({
    required String productId,
    int quantity = 1,
  }) {
    if (productId.isEmpty || quantity < 1) {
      throw RemoveCartItemException();
    }

    if (!_cart.containsKey(productId)) {
      throw RemoveCartItemException(
        message: ExceptionMessageConstants.cartItemToRemoveDoesNotExist,
      );
    }

    final inCartQuantity = _cart[productId]!.quantity;

    if (quantity >= inCartQuantity) {
      _cart.removeWhere((id, item) => id == productId);
    } else {
      _cart[productId]?.quantity -= quantity;
    }

    notifyListeners();
  }

  void removeItemFromCart({
    required String productId,
  }) {
    if (productId.isEmpty) {
      throw RemoveCartItemException();
    }

    if (!_cart.containsKey(productId)) {
      throw RemoveCartItemException(
        message: ExceptionMessageConstants.cartItemToRemoveDoesNotExist,
      );
    }

    _cart.removeWhere((id, item) => id == productId);

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/constants/exception_message_constants.dart';

import '../exceptions/remove_cart_item_exception.dart';
import '../exceptions/add_cart_item_exception.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _cart = {};

  Map<String, CartItem> get cart => {..._cart};

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
          id: '${DateTime.now().millisecondsSinceEpoch}',
          name: title,
          price: price,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem({
    required String itemId,
    int quantity = 1,
  }) {
    if (itemId.isEmpty || quantity < 1) {
      throw RemoveCartItemException();
    }

    if (!_cart.containsKey(itemId)) {
      throw RemoveCartItemException(
        message: ExceptionMessageConstants.cartItemToRemoveDoesNotExist,
      );
    }

    final inCartQuantity = _cart[itemId]!.quantity;

    if (quantity >= inCartQuantity) {
      _cart.removeWhere((id, item) => id == itemId);
    } else {
      _cart[itemId]?.quantity -= quantity;
    }

    notifyListeners();
  }
}

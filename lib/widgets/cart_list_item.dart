import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartListItem({
    super.key,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => price * quantity;

  String get totalPriceLabel {
    return '\$${totalPrice.toStringAsFixed(2)}';
  }

  String get priceLabel {
    return '\$${price.toStringAsFixed(2)}';
  }

  void onDecreaseCartItemQuantity(BuildContext context) {
    Provider.of<Cart>(context, listen: false).decreaseItemQuantity(productId: id);
  }

  void onRemoveCartItemCompletely(BuildContext context) {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(productId: id);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd || quantity == 1) {
          return true;
        } else {
          onDecreaseCartItemQuantity(context);
          return false;
        }
      },
      onDismissed: (direction) {
        onRemoveCartItemCompletely(context);
      },
      background: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(
            Icons.delete,
            size: 35,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(
            Icons.exposure_minus_1_rounded,
            size: 35,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 0,
        ),
        child: ListTile(
          leading: Container(
            width: 75,
            height: 40,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: FittedBox(
              child: Text(
                totalPriceLabel,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 17,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text("$quantity × $priceLabel"),
        ),
      ),
    );
  }
}

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

  void onRemoveCartItem(BuildContext context) {
    Provider.of<Cart>(context, listen: false).removeItem(productId: id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 10,
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
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () => onRemoveCartItem(context),
                icon: const Icon(Icons.delete_forever_rounded),
                label: const Text('Remove'),
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).errorColor,
                  ),
                ),
              )
            : IconButton(
                onPressed: () => onRemoveCartItem(context),
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );
  }
}

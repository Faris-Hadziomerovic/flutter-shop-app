import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';

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

  void onRemoveSingleItem(BuildContext context) {
    Provider.of<Cart>(context, listen: false).removeSingleItem(productId: id);
  }

  void onRemoveCartItemCompletely(BuildContext context) {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(productId: id);
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = Provider.of<Products>(context).getById(id).imageUrl;

    return Dismissible(
      key: ValueKey(id),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd || quantity == 1) {
          return showDialog(
              context: context,
              builder: ((ctx) {
                return AlertDialog(
                  title: const Text('Remove item'),
                  content: const Text('Do you want to completely remove this item from the cart?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('No'),
                    ),
                  ],
                );
              }));
        } else {
          onRemoveSingleItem(context);
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
            color: Theme.of(context).colorScheme.error,
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
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 0,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              width: 60,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text("$quantity × $priceLabel"),
        ),
      ),
    );
  }
}

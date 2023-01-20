import 'package:flutter/material.dart';

import '../models/order_item.dart';

class OrdersListItem extends StatelessWidget {
  final OrderItem order;

  const OrdersListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      child: Column(
        children: order.products.map((cartItem) {
          final title = cartItem.name;
          final quantity = cartItem.quantity;
          final priceLabel = '\$${cartItem.price.toStringAsFixed(2)}';
          final totalPriceLabel = '\$${(cartItem.price * quantity).toStringAsFixed(2)}';

          return ListTile(
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
          );
        }).toList(),
      ),
    );
  }
}

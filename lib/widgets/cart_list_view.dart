import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import './cart_list_item.dart';

class CartListView extends StatelessWidget {
  final double height;

  const CartListView({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Cart>(context).cart.values.toList();

    return SizedBox(
      height: height,
      child: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'The cart is currently empty, go out there and add something 😊',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              reverse: false,
              itemBuilder: (ctx, index) {
                final cartItem = items[items.length - 1 - index];
                return CartListItem(
                  key: ValueKey(cartItem.id),
                  id: cartItem.id,
                  title: cartItem.name,
                  quantity: cartItem.quantity,
                  price: cartItem.price,
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';
import '../../providers/products_provider.dart';

class OrdersListItem extends StatefulWidget {
  final OrderItem order;

  const OrdersListItem({super.key, required this.order});

  @override
  State<OrdersListItem> createState() => _OrdersListItemState();
}

class _OrdersListItemState extends State<OrdersListItem> {
  bool isExpanded = false;

  String get totalPriceLabel {
    return '\$${widget.order.amount.toStringAsFixed(2)}';
  }

  String get date {
    return DateFormat('dd. MMMM yyyy.').format(widget.order.dateTime).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            visualDensity: const VisualDensity(vertical: 2.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            title: Row(
              children: [
                Text(
                  'Total: ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 10),
                Text(
                  totalPriceLabel,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            subtitle: Text(date),
            trailing: IconButton(
              icon: Icon(
                isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Column(
              children: [
                const Divider(height: 0),
                ...widget.order.products.map((cartItem) {
                  final title = cartItem.name;
                  final quantity = cartItem.quantity;
                  final priceLabel = '\$${cartItem.price.toStringAsFixed(2)}';
                  final imageUrl = context.select<Products, String>(
                    (productsData) => productsData.getById(cartItem.id).imageUrl,
                  );
                  // Provider.of<Products>(context, listen: false).getById(cartItem.id).imageUrl;

                  return ListTile(
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
                  );
                }).toList(),
              ],
            ),
        ],
      ),
    );
  }
}

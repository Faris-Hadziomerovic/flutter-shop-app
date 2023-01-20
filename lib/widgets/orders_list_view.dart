import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/orders_list_item.dart';

import '../providers/orders_provider.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, i) {
        final index = orders.length - 1 - i;
        return OrdersListItem(order: orders[index]);
      },
    );
  }
}

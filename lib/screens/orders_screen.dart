import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/orders/orders_list_view.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  const OrdersScreen({super.key});

  Future<void> refresh(BuildContext context) async {
    return await Provider.of<Orders>(context, listen: false).fetchAndSetAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(currentRoute: routeName),
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: const OrdersList(),
      ),
    );
  }
}

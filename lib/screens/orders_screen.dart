import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/orders_list_view.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: const OrdersList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/cart_list_view.dart';
import '../widgets/checkout.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('My cart'),
    );

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final toolBarHeight = mediaQuery.padding.top;
    final appBarHeight = appBar.preferredSize.height;
    final usableHeight = screenHeight - appBarHeight - toolBarHeight;
    const checkoutHeight = 150.0;

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CartListView(
            height: usableHeight - checkoutHeight,
          ),
          const Checkout(
            width: double.infinity,
            height: checkoutHeight,
          ),
        ],
      ),
    );
  }
}

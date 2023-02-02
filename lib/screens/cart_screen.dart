import 'package:flutter/material.dart';

import '../widgets/cart/cart_list_view.dart';
import '../widgets/cart/checkout.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('My cart'),
    );

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final toolBarHeight = mediaQuery.padding.top;
    final appBarHeight = appBar.preferredSize.height;
    final usableHeight = screenHeight - appBarHeight - toolBarHeight;
    const checkoutHeight = 150.0;

    final viewIsNarrow = screenWidth < 450;
    final direction = viewIsNarrow ? Axis.vertical : Axis.horizontal;

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CartListView(
            height:
                viewIsNarrow ? usableHeight - checkoutHeight : usableHeight - (checkoutHeight / 2),
          ),
          Checkout(
            width: screenWidth,
            height: checkoutHeight,
            direction: direction,
          ),
        ],
      ),
    );
  }
}

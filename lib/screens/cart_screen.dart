import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart/cart_list_view.dart';
import '../widgets/cart/checkout.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  Future<void> refresh(BuildContext context) async {
    return Provider.of<Cart>(context, listen: false).fetchAndSetAsync();
  }

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
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CartListView(
              height: viewIsNarrow
                  ? usableHeight - checkoutHeight
                  : usableHeight - (checkoutHeight / 2),
            ),
            Checkout(
              width: screenWidth,
              height: checkoutHeight,
              direction: direction,
            ),
          ],
        ),
      ),
    );
  }
}

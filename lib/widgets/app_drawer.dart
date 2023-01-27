import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/products_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void navigateToShop(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.routeName);
  }

  void navigateToOrders(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
  }

  void navigateToCart(BuildContext context) {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  void navigateToSettings(BuildContext context) {
    Fluttertoast.showToast(
      msg: 'Settings feature is not yet implemented!',
      backgroundColor: Colors.black54,
      fontSize: 18,
    );
    // Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
  }

  Widget listTileWithBorder({
    required Icon leading,
    required Text title,
    required void Function() onTap,
    bool showTopBorder = false,
    bool showBottomBorder = false,
    BorderSide borderSide = const BorderSide(
      width: 0.1,
      color: Colors.black,
    ),
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder ? borderSide : BorderSide.none,
          bottom: showBottomBorder ? borderSide : BorderSide.none,
        ),
      ),
      child: ListTile(
        leading: leading,
        title: title,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu'),
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          listTileWithBorder(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text('Shop'),
            onTap: () => navigateToShop(context),
            showBottomBorder: true,
          ),
          listTileWithBorder(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Cart'),
            onTap: () => navigateToCart(context),
            showBottomBorder: true,
          ),
          listTileWithBorder(
            leading: const Icon(Icons.price_check_outlined),
            title: const Text('Orders'),
            onTap: () => navigateToOrders(context),
            showBottomBorder: true,
          ),
          const Spacer(),
          listTileWithBorder(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => navigateToSettings(context),
            showTopBorder: true,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/filter_options.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/notifications_badge.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview-screen';

  final String title;

  const ProductsOverviewScreen({super.key, this.title = 'Products overview'});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  FilterOptions _filterOptions = FilterOptions.all;

  void onNavigateToCart(BuildContext context) {
    Navigator.pushNamed(context, CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () => onNavigateToCart(context),
            child: SizedBox(
              width: 55,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Consumer<Cart>(
                  builder: (_, cart, icon) => NotificationsBadge(
                    quantity: cart.itemCount,
                    child: icon as Widget,
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              onSelected: (value) {
                setState(() {
                  _filterOptions = value;
                });
              },
              itemBuilder: (_) {
                return [
                  const PopupMenuItem(
                    value: FilterOptions.favourites,
                    child: Text('Show favourites'),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.all,
                    child: Text('Show all products'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(filterOptions: _filterOptions),
    );
  }
}
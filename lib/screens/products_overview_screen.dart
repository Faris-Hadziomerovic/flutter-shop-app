import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/filter_options.dart';
import '../helpers/navigator_helper.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/products-overview/notifications_badge.dart';
import '../widgets/products-overview/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  final String title;

  const ProductsOverviewScreen({super.key, this.title = 'Products overview'});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  FilterOptions _filterOptions = FilterOptions.all;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).fetchAndSetAsync();
  }

  void onNavigateToCart(BuildContext context) {
    Navigator.pushNamed(context, CartScreen.routeName);
  }

  Future<void> refresh(BuildContext context) async {
    return Provider.of<Products>(context, listen: false).fetchAndSetAsync();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => NavigatorHelper.showExitAppDialog(context),
      child: Scaffold(
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
        drawer: const AppDrawer(currentRoute: ProductsOverviewScreen.routeName),
        body: RefreshIndicator(
          onRefresh: () => refresh(context),
          child: ProductsGrid(filterOptions: _filterOptions),
        ),
      ),
    );
  }
}

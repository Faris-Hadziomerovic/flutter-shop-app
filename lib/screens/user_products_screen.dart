import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/navigator_helper.dart';
import '../providers/products_provider.dart';
import '../screens/add_edit_user_products_screen.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/user-products/user_products_list_view.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  void onAddNewProduct(BuildContext context) {
    Navigator.of(context).pushNamed(AddEditUserProductsScreen.routeName);
  }

  Future<void> refresh(BuildContext context) async {
    return Provider.of<Products>(context, listen: false).fetchAndSetAsync();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => NavigatorHelper.returnToHomeScreen(context),
      child: Scaffold(
        drawer: const AppDrawer(currentRoute: routeName),
        appBar: AppBar(
          title: const Text('User Products'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () => onAddNewProduct(context),
                icon: const Icon(Icons.add_rounded),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          splashColor: Theme.of(context).colorScheme.secondary,
          onPressed: () => onAddNewProduct(context),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add new product'),
        ),
        body: RefreshIndicator(
          onRefresh: () => refresh(context),
          child: const UserProductsListView(),
        ),
      ),
    );
  }
}

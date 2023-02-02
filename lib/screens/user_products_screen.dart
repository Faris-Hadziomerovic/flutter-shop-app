import 'package:flutter/material.dart';

import '../widgets/drawers/app_drawer.dart';
import '../widgets/user-products/user_products_list_view.dart';
import '../screens/add_edit_user_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  void onAddNewProduct(BuildContext context) {
    Navigator.of(context).pushNamed(AddEditUserProductsScreen.newProductRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const UserProductsListView(),
    );
  }
}

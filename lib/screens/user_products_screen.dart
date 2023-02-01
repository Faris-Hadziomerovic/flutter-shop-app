import 'package:flutter/material.dart';

import '../helpers/generic_toast_messages.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/user-products/user_products_list_view.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  void onSave(BuildContext context) {
    HelperToast.showNotImplementedToast();
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
              onPressed: () => onSave(context),
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: const UserProductsListView(),
    );
  }
}

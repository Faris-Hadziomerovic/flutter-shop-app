import 'package:flutter/material.dart';
import 'package:shop_app/widgets/drawers/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: routeName),
      appBar: AppBar(
        title: const Text('User Products'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(),
    );
  }
}

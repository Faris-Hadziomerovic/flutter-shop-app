import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import './user_products_list_item.dart';

class UserProductsListView extends StatelessWidget {
  const UserProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).products;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        final product = products[index];

        return UserProductsListItem(product: product);
      },
    );
  }
}

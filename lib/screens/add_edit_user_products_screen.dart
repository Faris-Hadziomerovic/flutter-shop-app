import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/add-edit-user-products/product_properties_form.dart';

class AddEditUserProductsScreen extends StatelessWidget {
  static const routeName = '/add-edit-user-product';

  const AddEditUserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String?;
    final product = productId != null ? Provider.of<Products>(context).getById(productId) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(productId != null ? 'Edit Product' : 'New Product'),
      ),
      body: ProductPropertiesForm(product: product),
    );
  }
}

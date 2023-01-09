import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details-screen';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    final product = Provider.of<Products>(context).getById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                context.read<Products>().toggleFavourite(productId);
              },
              icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_outline),
            ),
          )
        ],
      ),
      body: Text(product.description),
    );
  }
}

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
              onPressed: null,
              icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_outline),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                product.title,
                textAlign: TextAlign.left,
                // change the style further
                style: Theme.of(context).textTheme.headline5?.copyWith(),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.left,
                // change the style further
                style: Theme.of(context).textTheme.bodyText2?.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

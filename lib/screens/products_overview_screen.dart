import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/products-overview-screen';

  final List<Product> products;

  const ProductsOverviewScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    const title = 'Products overview';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: products.isEmpty
          ? const Center(
              child: Text('No products available'),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  id: products[index].id,
                  title: products[index].title,
                  imageUrl: products[index].imageUrl,
                  price: products[index].price,
                );
              },
            ),
    );
  }
}

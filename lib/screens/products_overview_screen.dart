import 'package:flutter/material.dart';

import '../widgets/products_overview_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/products-overview-screen';

  final String title;

  const ProductsOverviewScreen({super.key, this.title = 'Products overview'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const ProductsOverviewGrid(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/filter_options.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final FilterOptions filterOptions;

  const ProductsGrid({super.key, this.filterOptions = FilterOptions.all});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final productsProvider = Provider.of<Products>(context);
    // final products = context.watch<Products>().products;
    final products = filterOptions == FilterOptions.favourites
        ? productsProvider.favouriteProducts
        : productsProvider.products;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: 2.5 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: const ProductItem(),
        );
      },
    );
  }
}

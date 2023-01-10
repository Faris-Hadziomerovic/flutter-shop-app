import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  void onFavourite(BuildContext context) {
    Provider.of<Product>(context, listen: false).toggleFavourite();
    // context.read<Product>().toggleFavourite();
  }

  void navigateToDetailsScreen(BuildContext context, String id) {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    final priceTag = '\$${product.price.toStringAsFixed(2)}';

    return GridTile(
      footer: SizedBox(
        height: 50,
        child: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: product.isFavourite ? Colors.red : Colors.white60,
            ),
            onPressed: () => onFavourite(context),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          title: Text(product.title),
          subtitle: Text(
            priceTag,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => navigateToDetailsScreen(context, product.id),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

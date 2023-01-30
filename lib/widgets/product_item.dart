import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/cart_provider.dart';
import '../providers/product.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  void navigateToDetailsScreen(BuildContext context, String id) {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: id,
    );
  }

  void onFavourite(BuildContext context, Product product) {
    final isFavourite = product.toggleFavourite();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: Text(isFavourite
            ? '${product.title} added to favourites.'
            : '${product.title} removed from favourites.'),
      ),
    );
  }

  void onAddToCart(BuildContext context, Product product) {
    Provider.of<Cart>(context, listen: false).addItem(
      itemId: product.id,
      title: product.title,
      price: product.price,
    );

    Fluttertoast.showToast(
      msg: '${product.title} added to cart.',
      backgroundColor: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final priceTag = '\$${product.price.toStringAsFixed(2)}';

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: SizedBox(
          height: 50,
          child: GridTileBar(
            backgroundColor: Colors.black38,
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: product.isFavourite ? Colors.red : Colors.white60,
              ),
              onPressed: () => onFavourite(context, product),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => onAddToCart(context, product),
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
      ),
    );
  }
}

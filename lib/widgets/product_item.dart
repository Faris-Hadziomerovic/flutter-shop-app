import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final bool isFavourite;

  const ProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
    required this.price,
    required this.isFavourite,
  });

  String get priceTag => '\$${price.toStringAsFixed(2)}';

  void onFavourite(BuildContext context) {
    Provider.of<Products>(context, listen: false).toggleFavourite(id);
    // context.read<Products>().toggleFavourite(id);
  }

  void navigateToDetailsScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: SizedBox(
        height: 50,
        child: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: isFavourite ? Colors.red : Colors.white60,
            ),
            onPressed: () => onFavourite(context),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          title: Text(title),
          subtitle: Text(
            priceTag,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => navigateToDetailsScreen(context),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

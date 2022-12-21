import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  const ProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
    required this.price,
  });

  String get priceTag => '\$${price.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: SizedBox(
        height: 50,
        child: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
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
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

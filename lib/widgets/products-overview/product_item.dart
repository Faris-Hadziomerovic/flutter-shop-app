import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product.dart';
import '../../providers/products_provider.dart';
import '../../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  void navigateToDetailsScreen(BuildContext context, String id) {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: id,
    );
  }

  Future<void> onFavourite(BuildContext context, Product product) async {
    final isFavourite =
        await Provider.of<Products>(context, listen: false).toggleFavouriteAsync(id: product.id);

    Fluttertoast.showToast(
      backgroundColor: Colors.black54,
      msg: isFavourite
          ? '${product.title} added to favourites.'
          : '${product.title} removed from favourites.',
    );
  }

  Future<void> onAddToCart(BuildContext context, Product product) async {
    final scaffoldMessanger = ScaffoldMessenger.of(context);

    await Provider.of<Cart>(context, listen: false).addAsync(
      cartItem: CartItem(
        id: product.id,
        name: product.title,
        price: product.price,
      ),
    );

    scaffoldMessanger.hideCurrentSnackBar();

    scaffoldMessanger.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: Text('${product.title} added to cart.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => onUndoAddToCart(context, product),
        ),
      ),
    );
  }

  Future<void> onUndoAddToCart(BuildContext context, Product product) async {
    final scaffoldMessanger = ScaffoldMessenger.of(context);

    await Provider.of<Cart>(context, listen: false).decreaseQuantityAsync(id: product.id);

    scaffoldMessanger.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: Text('${product.title} removed from cart.'),
      ),
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
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Container(
                  color: Colors.black12,
                  child: const Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

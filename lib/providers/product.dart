import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  late final String title;
  late final String description;
  late final String imageUrl;
  late final double price;
  late bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavourite = false,
  });

  Product.fromMap({required this.id, required Map<String, dynamic> productData}) {
    title = productData['title'] as String;
    description = productData['description'] as String;
    imageUrl = productData['imageUrl'] as String;
    price = (productData['price'] as num).toDouble();
    isFavourite = productData['isFavourite'] as bool? ?? false;
  }

  Map<String, Object> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'isFavourite': isFavourite,
    };
  }

  bool toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
    return isFavourite;
  }
}

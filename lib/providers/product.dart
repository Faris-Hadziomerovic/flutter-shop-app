import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  late final String title;
  late final String description;
  late final String imageUrl;
  late final double price;
  late bool isFavourite;

  static String get idKey => 'id';
  static String get titleKey => 'title';
  static String get descriptionKey => 'description';
  static String get imageUrlKey => 'imageUrl';
  static String get priceKey => 'price';
  static String get isFavouriteKey => 'isFavourite';

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavourite = false,
  });

  Product.fromMap({required this.id, required Map<String, dynamic> productData}) {
    title = productData[titleKey] as String;
    description = productData[descriptionKey] as String;
    imageUrl = productData[imageUrlKey] as String;
    price = (productData[priceKey] as num).toDouble();
    isFavourite = productData[isFavouriteKey] as bool? ?? false;
  }

  Map<String, Object> toMap() {
    return {
      titleKey: title,
      descriptionKey: description,
      imageUrlKey: imageUrl,
      priceKey: price,
      isFavouriteKey: isFavourite,
    };
  }

  bool toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
    return isFavourite;
  }
}

import 'package:shop_app/providers/product.dart';

class MutableProduct {
  late final String id;
  String? title;
  String? description;
  String? imageUrl;
  double? price;
  bool? isFavourite;

  MutableProduct({
    required this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.isFavourite = false,
  });

  MutableProduct.fromProduct({required Product product}) {
    id = product.id;
    title = product.title;
    description = product.description;
    imageUrl = product.imageUrl;
    price = product.price;
    isFavourite = product.isFavourite;
  }

  Product toProduct() {
    return Product(
      id: id,
      title: title ?? 'no title provided',
      description: description ?? 'no description provided',
      imageUrl: imageUrl ?? 'no image provided',
      price: price ?? 0.00,
      isFavourite: isFavourite ?? false,
    );
  }

  @override
  String toString() {
    return '''{
      id: $id,
      title: $title,
      price: $price,
      description: $description,
      imageUrl: $imageUrl,
      isFavourite: $isFavourite, \n}''';
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/exceptions/add_product_exception.dart';

import '../exceptions/item_does_not_exist_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products => [..._products];

  List<Product> get favouriteProducts => [..._products.where((product) => product.isFavourite)];

  Product getById(String id) {
    return products.firstWhere((product) => product.id == id);
  }

  void update({required String id, required Product updatedProduct}) {
    var index = _products.indexWhere((product) => product.id == id);

    if (index == -1) throw ItemDoesNotExistException();

    _products[index] = Product(
      id: id,
      title: updatedProduct.title,
      description: updatedProduct.description,
      imageUrl: updatedProduct.imageUrl,
      price: updatedProduct.price,
    );

    notifyListeners();
  }

  Future<void> add(Product product, {bool insertAsFirst = false}) async {
    final url = Uri.https(
      'shop-app-115-default-rtdb.europe-west1.firebasedatabase.app',
      '/products.json',
    );

    return http.post(url, body: jsonEncode(product.toJSON())).then((response) {
      if (response.statusCode != 200) throw HttpException(response.body, uri: url);

      if (insertAsFirst) {
        _products.insert(0, product);
      } else {
        _products.add(product);
      }

      notifyListeners();
    }).catchError((error) {
      throw AddProductException();
    });
  }

  void toggleFavourite(String id) {
    var product = _products.firstWhereOrNull((product) => product.id == id);

    if (product != null) {
      product.isFavourite = !product.isFavourite;
      notifyListeners();
    }
  }

  void remove(Product product) {
    if (_products.remove(product)) {
      notifyListeners();
    }
  }

  void removeById(String id) {
    final product = _products.firstWhereOrNull((product) => product.id == id);

    if (product != null) {
      remove(product);
    }
  }
}

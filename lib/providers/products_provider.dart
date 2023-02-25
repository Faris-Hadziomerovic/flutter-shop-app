import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../constants/endpoints.dart';
import '../exceptions/add_product_exception.dart';
import '../exceptions/fetch_products_exception.dart';
import '../exceptions/delete_product_exception.dart';
import '../exceptions/item_does_not_exist_exception.dart';
import '../exceptions/update_product_exception.dart';
import '../helpers/http_helper.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _localProducts = [];

  List<Product> get localProducts => [..._localProducts];

  List<Product> get favouriteProducts =>
      [..._localProducts.where((product) => product.isFavourite)];

  Product getLocalById(String id) {
    return localProducts.firstWhere((product) => product.id == id);
  }

  Future<Product> getByIdAsync(String id) async {
    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id');

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      final responseData = jsonDecode(response.body);

      return Product(
        id: id,
        title: responseData['title'],
        description: responseData['description'],
        imageUrl: responseData['imageUrl'],
        price: (responseData['price'] as num).toDouble(),
      );
    } on Exception {
      throw FetchProductsException();
    }
  }

  Future<void> fetchAndSetAsync() async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.products);

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      _localProducts.clear();

      if (responseData == null) return;

      responseData.forEach((productId, productData) {
        final product = Product.fromMap(id: productId, productData: productData);
        _localProducts.add(product);
      });

      notifyListeners();
    } on Exception {
      throw FetchProductsException();
    }
  }

  Future<void> addAsync(Product product, {bool insertAsFirst = false}) async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.products);

    try {
      final response = await http.post(url, body: jsonEncode(product.toMap()));

      HttpHelper.throwIfNot200(response);

      final id = jsonDecode(response.body)[ApiConstants.firebaseGetResponseIdKey];

      final newProduct = Product(
        id: id,
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      );

      if (insertAsFirst) {
        _localProducts.insert(0, newProduct);
      } else {
        _localProducts.add(newProduct);
      }

      notifyListeners();
    } on Exception {
      throw AddProductException();
    }
  }

  Future<void> updateAsync({
    required String id,
    required Product updatedProduct,
  }) async {
    var index = _localProducts.indexWhere((product) => product.id == id);

    if (index == -1) throw ItemDoesNotExistException();

    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id');

    try {
      final response = await http.put(url, body: jsonEncode(updatedProduct.toMap()));

      HttpHelper.throwIfNot200(response);

      _localProducts[index] = Product(
        id: id,
        title: updatedProduct.title,
        description: updatedProduct.description,
        imageUrl: updatedProduct.imageUrl,
        price: updatedProduct.price,
        isFavourite: updatedProduct.isFavourite,
      );

      notifyListeners();
    } on Exception {
      throw UpdateProductException();
    }
  }

  Future<void> deleteAsync({required String id}) async {
    var index = _localProducts.indexWhere((product) => product.id == id);

    if (index == -1) throw ItemDoesNotExistException();

    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id');

    try {
      final response = await http.delete(url);

      HttpHelper.throwIfNot200(response);

      _removeLocalById(id);
    } on Exception {
      throw DeleteProductException();
    }
  }

  Future<bool> toggleFavouriteAsync(String id) async {
    var product = _localProducts.firstWhereOrNull((product) => product.id == id);

    if (product == null) throw ItemDoesNotExistException();

    final isFavourite = _toggleFavourite(product);

    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id/isFavourite');

    http.put(url, body: jsonEncode(isFavourite));

    return isFavourite;
  }

  bool _toggleFavourite(Product product) {
    return product.toggleFavourite();
  }

  void _removeLocal(Product product) {
    if (_localProducts.remove(product)) {
      notifyListeners();
    }
  }

  void _removeLocalById(String id) {
    final product = _localProducts.firstWhereOrNull((product) => product.id == id);

    if (product != null) {
      _removeLocal(product);
    }
  }
}

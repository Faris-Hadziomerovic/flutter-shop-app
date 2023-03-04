import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../constants/endpoints.dart';
import '../exceptions/backup/product_recovery_exception.dart';
import '../exceptions/product/add_product_exception.dart';
import '../exceptions/product/delete_product_exception.dart';
import '../exceptions/product/fetch_products_exception.dart';
import '../exceptions/product/product_not_found_exception.dart';
import '../exceptions/product/update_product_exception.dart';
import '../helpers/http_helper.dart';
import '../services/backup_service.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _localProducts = [];

  final List<Product> _draftProducts = [];

  List<Product> get products => [..._localProducts];

  List<Product> get draftProducts => [..._draftProducts];

  List<Product> get favouriteProducts =>
      [..._localProducts.where((product) => product.isFavourite)];

  Product getLocalById({required String id}) {
    return products.firstWhere((product) => product.id == id);
  }

  Future<Product> getByIdAsync({required String id}) async {
    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id');

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      final responseData = jsonDecode(response.body);

      return Product.fromMap(
        id: id,
        productData: responseData,
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

  Future<void> recoverBackupAsync() async {
    try {
      var recoveredProducts = await BackupService.recoverProductsAsync();

      if (recoveredProducts.isEmpty) return;

      await fetchAndSetAsync();

      recoveredProducts = _getMissingProducts(recoveredProducts);

      final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.products);

      for (final product in recoveredProducts) {
        final response = await http.patch(
          url,
          body: jsonEncode(
            {product.id: product.toMap()},
          ),
        );

        HttpHelper.throwIfNot200(response);

        _localProducts.add(product);
      }

      notifyListeners();
    } on Exception {
      throw ProductRecoveryException();
    }
  }

  Future<void> addAsync({required Product product, bool insertAsFirst = false}) async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.products);

    try {
      final response = await http.post(url, body: jsonEncode(product.toMap()));

      HttpHelper.throwIfNot200(response);

      final id = jsonDecode(response.body)[ApiConstants.firebasePostResponseIdKey];

      final newProduct = Product(
        id: id,
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      );

      await BackupService.backupProductAsync(newProduct);

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

  Future<void> updateAsync({required String id, required Product updatedProduct}) async {
    var index = _localProducts.indexWhere((product) => product.id == id);

    if (index == -1) throw ProductNotFoundException();

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

    if (index == -1) throw ProductNotFoundException();

    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id');

    try {
      final response = await http.delete(url);

      HttpHelper.throwIfNot200(response);

      _removeLocalById(id);
    } on Exception {
      throw DeleteProductException();
    }
  }

  Future<bool> toggleFavouriteAsync({required String id}) async {
    var product = _localProducts.firstWhereOrNull((product) => product.id == id);

    if (product == null) throw ProductNotFoundException();

    final isFavourite = _toggleFavourite(product);

    final url = HttpHelper.generateFirebaseURL(
      endpoint: '${Endpoints.products}/$id/${Product.isFavouriteKey}',
    );

    http.put(url, body: jsonEncode(isFavourite));

    return isFavourite;
  }

  bool _toggleFavourite(Product product) {
    return product.toggleFavourite();
  }

  List<Product> _getMissingProducts(List<Product> recoveredProducts) {
    final existingProductIds = _localProducts.map((product) => product.id).toSet();

    return recoveredProducts.where((product) => existingProductIds.add(product.id)).toList();
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

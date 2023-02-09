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
  final List<Product> _localProducts = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

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
    } catch (error) {
      throw FetchProductsException();
    }
  }

  Future<void> fetchAndSetAsync() async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.products);

    try {
      final response = await http.get(url);

      HttpHelper.throwIfNot200(response);

      final responseData = jsonDecode(response.body);

      _localProducts.clear();

      if (responseData == null) return;

      responseData.forEach((productId, productData) {
        final product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          imageUrl: productData['imageUrl'],
          price: (productData['price'] as num).toDouble(),
        );

        _localProducts.add(product);
      });

      notifyListeners();
    } catch (error) {
      throw FetchProductsException();
    }
  }

  Future<void> addAsync(Product product, {bool insertAsFirst = false}) async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.products);

    try {
      final response = await http.post(url, body: jsonEncode(product.toJSON()));

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
    } catch (error) {
      throw AddProductException();
    }
  }

  Future<void> updateAsync({required String id, required Product updatedProduct}) async {
    var index = _localProducts.indexWhere((product) => product.id == id);

    if (index == -1) throw ItemDoesNotExistException();

    final url = HttpHelper.generateFirebaseURL(endpoint: '${Endpoints.products}/$id');

    try {
      final response = await http.put(url, body: jsonEncode(updatedProduct.toJSON()));

      HttpHelper.throwIfNot200(response);

      _localProducts[index] = Product(
        id: id,
        title: updatedProduct.title,
        description: updatedProduct.description,
        imageUrl: updatedProduct.imageUrl,
        price: updatedProduct.price,
      );

      notifyListeners();
    } catch (error) {
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

      notifyListeners();
    } catch (error) {
      throw DeleteProductException();
    }
  }

  void toggleFavourite(String id) {
    var product = _localProducts.firstWhereOrNull((product) => product.id == id);

    if (product != null) {
      product.isFavourite = !product.isFavourite;
      notifyListeners();
    }
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

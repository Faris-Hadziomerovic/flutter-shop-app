import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';
import '../exceptions/backup/product_backup_exception.dart';
import '../helpers/http_helper.dart';
import '../providers/product.dart';

class BackupService {
  static Future<void> backupProductAsync(Product product) async {
    final url = HttpHelper.generateFirebaseURL(
      endpoint: '${Endpoints.backupProducts}/${product.id}',
    );

    try {
      final response = await http.put(url, body: jsonEncode(product.toMap()));

      HttpHelper.throwIfNot200(response);
    } on Exception {
      throw ProductBackupException();
    }
  }

  static Future<List<Product>> recoverProductsAsync() async {
    final url = HttpHelper.generateFirebaseURL(endpoint: Endpoints.backupProducts);

    try {
      final response = await http.get(url);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      if (responseData == null) return [];

      final recoveredProducts = <Product>[];

      responseData.forEach((productId, productData) {
        final product = Product.fromMap(id: productId, productData: productData);
        recoveredProducts.add(product);
      });

      return recoveredProducts;
    } on Exception {
      throw ProductBackupException();
    }
  }
}

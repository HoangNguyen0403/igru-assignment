// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import '../../gen/assets.gen.dart';
import 'models/product.dart';

class ProductRepository {
  Future<List<Product>> getProducts({
    ProductType? productType,
    int totalItems = 9999,
  }) async {
    final List<dynamic> response = jsonDecode(
      await rootBundle.loadString(Assets.json.productResponse),
    );

    return response
        .map((product) => Product.fromJson(product))
        .where((product) {
          if (productType == null) return true;

          return product.productType == productType;
        })
        .take(totalItems)
        .toList();
  }
}

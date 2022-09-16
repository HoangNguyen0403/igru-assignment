// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import '../../gen/assets.gen.dart';
import 'models/product.dart';

class ProductRepository {
  Future<List<Product>> getProducts({ProductType? productType}) async {
    final List<dynamic> response = jsonDecode(
      await rootBundle.loadString(Assets.json.productResponse),
    );

    return response
        .map((product) => Product.fromJson(product))
        .where((product) {
      if (productType == null) return true;

      return product.productType == productType;
    }).toList();
  }
}

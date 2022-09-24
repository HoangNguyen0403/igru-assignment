// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:igru_assignment/gen/assets.gen.dart';
import 'package:igru_assignment/repositories/products/models/product.dart';
import 'package:igru_assignment/repositories/products/product_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final ProductRepository productRepository = ProductRepository();
  group('Product Repository', () {
    test('Get products with all type', () async {
      final List<dynamic> response = jsonDecode(
        await rootBundle.loadString(Assets.json.productResponse),
      );

      final matcher =
          response.map((product) => Product.fromJson(product)).toList();

      expect(await productRepository.getProducts(), matcher);
    });

    test('Get products with specific type', () async {
      const ProductType productType = ProductType.apparel;

      final List<dynamic> response = jsonDecode(
        await rootBundle.loadString(Assets.json.productResponse),
      );

      final matcher = response
          .map((product) => Product.fromJson(product))
          .where((productMap) => productMap.productType == productType)
          .toList();

      expect(
        (await productRepository.getProducts(productType: productType)).length,
        matcher.length,
      );
    });
  });
}

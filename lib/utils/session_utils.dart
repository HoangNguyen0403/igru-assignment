// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../database/hive_manager.dart';
import '../database/models/product_in_database.dart';
import '../repositories/products/models/product.dart';
import 'di/injection.dart';
import 'multi-languages/multi_languages_utils.dart';
import 'shared_pref_manager.dart';

class SessionUtils {
  static void saveAccessToken(String accessToken) =>
      getIt<SharedPreferencesManager>().putString(
        SharedPreferenceKey.keyAccessToken,
        accessToken,
      );

  static bool get isMobile {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

    return data.size.shortestSide < 550;
  }

  static String priceDisplay(double price) {
    return NumberFormat.currency(
      symbol: "\$",
      decimalDigits: 2,
    ).format(price);
  }

  static void addProductToCart(Product product) {
    getIt<HiveManager>().putDataWithKey<ProductInDatabase>(
      HiveBoxKey.products.name,
      product.id.toString(),
      product.productLocalDB,
    );
  }

  static List<Product> getProductFromDB() {
    final products = getIt<HiveManager>().getListData<ProductInDatabase>(
      HiveBoxKey.products.name,
    );

    return products.map((productInDB) => productInDB.productResponse).toList();
  }

  static void removeProductFromDB(Product product) {
    getIt<HiveManager>().deleteDataWithKey(
      HiveBoxKey.products.name,
      product.id.toString(),
    );
  }

  static void clearCart() {
    getIt<HiveManager>().deleteAllDataFromBox(HiveBoxKey.products.name);
  }
}

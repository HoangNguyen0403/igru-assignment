// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

// Project imports:
import 'package:igru_assignment/database/hive_manager.dart';
import 'package:igru_assignment/repositories/products/models/product.dart';
import 'package:igru_assignment/utils/di/injection.dart';
import 'path_provider_mock.dart';

class Utility {
  static Future<void> mockHive(String testPath) async {
    PathProviderPlatform.instance = FakePathProviderPlatform(testPath);

    getIt.registerSingleton(HiveManager());
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxKey.products.name);
  }

  static Future<void> unMockHive() async {
    getIt.unregister<HiveManager>();
  }

  static void setScreenForTest(WidgetTester tester) {
    const width = 411.4;
    const height = 900.0;
    tester.binding.window.devicePixelRatioTestValue = (2.625);
    final dpi = tester.binding.window.devicePixelRatio;
    tester.binding.window.physicalSizeTestValue =
        Size(width * dpi, height * dpi);
  }

  static List<Product> get mockProducts => [
        Product.fromJson(
          const {
            "id": 4,
            "name": "Short Jean",
            "price": 23.1,
            "imageUrl": "https://picsum.photos/id/100/2500/1656",
            "description":
                "Jean is a woman in her early 30s who loves to cook. She is married to a man in his early 40s and they have a 2-year-old son. Jean spends her days cooking, cleaning, and taking care of her family. When Jean goes to the grocery store, she feels the need to make the whole house smell like whatever she's cooking. In her new cookbook, the author shares recipes for homemade sprays, rubs, and spices that make food taste better and the house smell fantastic. Jean will use these recipes to make everything from condiments to desserts to a unique house scent.",
            "selected": false,
            "productType": "apparel",
            "imagesDetail": [
              "https://picsum.photos/id/0/5616/3744",
              "https://picsum.photos/id/113/4168/2464",
            ],
          },
        ),
        Product.fromJson(
          const {
            "id": 10,
            "name": "Helmet",
            "price": 33.42,
            "imageUrl": "https://picsum.photos/id/1067/5760/3840",
            "description":
                "There are many kinds of helmets to choose from. They vary from full face helmets, to half helmets, to open face helmets, to non-face helmets. Full face helmets provide the most protection and are the most expensive. Half helmets provide less protection and are less expensive. Open face helmets are not protective and are cheaper.",
            "selected": false,
            "productType": "apparel",
            "imagesDetail": [
              "https://picsum.photos/id/1067/5760/3840",
              "https://picsum.photos/id/1066/2144/1424",
            ],
          },
        ),
      ];
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:igru_assignment/database/hive_manager.dart';
import 'package:igru_assignment/utils/di/injection.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

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
}

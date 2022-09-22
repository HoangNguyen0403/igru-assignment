// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import '../../database/hive_manager.dart';
import '../../repositories/products/product_repository.dart';
import '../shared_pref_manager.dart';

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  registerRepository();
}

void registerRepository() {
  getIt.registerSingleton(ProductRepository());
}

Future _registerAppComponents() async {
  final sharedPreferencesManager = await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager!);

  final hiveManager = await HiveManager.getInstance();
  getIt.registerSingleton<HiveManager>(hiveManager);
}

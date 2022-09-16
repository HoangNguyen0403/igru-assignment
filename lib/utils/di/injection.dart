// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import '../../config/theme.dart';
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

  final appTheme = AppTheme();
  getIt.registerSingleton(appTheme);
}

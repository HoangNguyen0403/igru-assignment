import 'package:get_it/get_it.dart';

import '../../config/theme.dart';
import '../shared_pref_manager.dart';

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
}

Future _registerAppComponents() async {
  final sharedPreferencesManager = await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager!);

  final appTheme = AppTheme();
  getIt.registerSingleton(appTheme);
}

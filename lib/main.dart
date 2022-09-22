// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'config/navigation_util.dart';
import 'database/models/product_in_database.dart';
import 'utils/di/injection.dart';
import 'utils/route/app_routing.dart';

void main() async {
  await _beforeRunApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations', //Using translations path if using json file
      child: MyApp(),
    ),
  );
}

Future<void> _beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await _initHiveDatabase();

  await setupInjection();
}

Future<void> _initHiveDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductInDatabaseAdapter());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 800),
      minTextAdapt: true,
      builder: (_, __) => MaterialApp(
        builder: (context, child) {
          return child ?? const SizedBox();
        },
        title: 'Flutter Template',
        navigatorKey: NavigationUtil.rootKey,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteDefine.homeScreen.name,
        onGenerateRoute: AppRouting.generateRoute,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}

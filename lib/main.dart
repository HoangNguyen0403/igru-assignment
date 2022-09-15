import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/navigation_util.dart';
import 'config/theme.dart';
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

  await setupInjection();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme appTheme = getIt<AppTheme>();

  @override
  void initState() {
    appTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    appTheme.dispose();
    super.dispose();
  }

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
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appTheme.currentTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}

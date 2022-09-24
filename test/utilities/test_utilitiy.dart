// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:igru_assignment/config/navigation_util.dart';
import 'package:igru_assignment/utils/route/app_routing.dart';

/// Wrapper for wrapping widget in Material App.
/// This will avoid UI exception when running widget.
class TestWidgetWrapper extends StatelessWidget {
  final Widget child;

  const TestWidgetWrapper({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => AppRouting.generateRoute(settings),
      navigatorKey: NavigationUtil.rootKey,
      home: MediaQuery(
        data: const MediaQueryData(),
        child: ScreenUtilInit(
          designSize: const Size(375, 800),
          builder: (_, __) => child,
        ),
      ),
    );
  }
}

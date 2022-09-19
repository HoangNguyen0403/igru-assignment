// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../config/theme.dart';
import 'di/injection.dart';
import 'multi-languages/multi_languages_utils.dart';
import 'shared_pref_manager.dart';

class SessionUtils {
  static bool get isDarkTheme =>
      getIt<AppTheme>().currentTheme == ThemeMode.dark;

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
}

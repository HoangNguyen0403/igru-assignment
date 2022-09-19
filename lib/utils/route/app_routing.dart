// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../repositories/products/models/product.dart';
import '../../ui/category/category_list/category_list_route.dart';
import '../../ui/category/product_detail/product_detail_route.dart';
import '../../ui/home/home_route.dart';
import '../../ui/home/ui/home_screen.dart';

enum RouteDefine {
  homeScreen,
  categoryListScreen,
  productDetailScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
      RouteDefine.categoryListScreen.name: (_) => CategoryListRoute.route(
            category: settings.arguments as Category,
          ),
      RouteDefine.productDetailScreen.name: (_) => ProductDetailRoute.route(
            settings.arguments as Product,
          ),
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}

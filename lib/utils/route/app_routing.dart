// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../repositories/products/models/product.dart';
import '../../ui/cart/cart_route.dart';
import '../../ui/category/category_list/category_list_route.dart';
import '../../ui/category/product_detail/product_detail_route.dart';
import '../../ui/checkout/checkout_route.dart';
import '../../ui/home/home_route.dart';
import '../../ui/home/ui/home_screen.dart';

enum RouteDefine {
  homeScreen,
  categoryListScreen,
  productDetailScreen,
  checkoutScreen,
  cartScreen,
}

class AppRouting {
  static PageRouteBuilder generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
      RouteDefine.categoryListScreen.name: (_) => CategoryListRoute.route(
            category: settings.arguments as Category,
          ),
      RouteDefine.productDetailScreen.name: (_) => ProductDetailRoute.route(
            settings.arguments as Product,
          ),
      RouteDefine.checkoutScreen.name: (_) => CheckoutRoute.route(
            settings.arguments as CheckoutArgs,
          ),
      RouteDefine.cartScreen.name: (_) => CartRoute.route,
    };

    final routeBuilder = routes[settings.name];

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          routeBuilder!(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      settings: RouteSettings(name: settings.name),
    );
  }
}

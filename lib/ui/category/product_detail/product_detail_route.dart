// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import '../../../repositories/products/models/product.dart';
import 'ui/product_detail_screen.dart';

class ProductDetailRoute {
  static Widget route(Product product) =>
      ProductDetailScreen(productSelected: product);
}

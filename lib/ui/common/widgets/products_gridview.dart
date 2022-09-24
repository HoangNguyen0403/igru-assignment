// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../repositories/products/models/product.dart';
import '../../../utils/session_utils.dart';
import 'product_card.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;
  final bool displayFavorite;
  const ProductGridView({
    required this.products,
    this.displayFavorite = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: SessionUtils.isMobile ? 2 : 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        mainAxisExtent: 240.h,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => ProductCard(
          product: products[index],
        ),
        childCount: products.length,
      ),
    );
  }
}

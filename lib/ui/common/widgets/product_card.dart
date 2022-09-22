// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../repositories/products/models/product.dart';
import '../../../utils/route/app_routing.dart';
import '../../../utils/session_utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteDefine.productDetailScreen.name,
          arguments: product,
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      cacheKey: product.imageUrl,
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              product.name,
              style: AppTextStyle.bodyL.copyWith(color: AppColors.body),
            ),
            SizedBox(height: 5.h),
            Text(
              SessionUtils.priceDisplay(product.price),
              style: AppTextStyle.price,
            ),
          ],
        ),
      ),
    );
  }
}

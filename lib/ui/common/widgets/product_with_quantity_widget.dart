// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/styles.dart';
import '../../../repositories/products/models/product.dart';
import '../../../utils/session_utils.dart';
import '../../checkout/ui/quantity_widget.dart';

class ProductWithQuantity extends StatelessWidget {
  final Product product;
  final Function(int quantity) onUpdateQuantity;
  const ProductWithQuantity({
    required this.product,
    required this.onUpdateQuantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 150.h,
      child: Row(
        children: [
          SizedBox(
            width: 110.w,
            height: 150.h,
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
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(10.h, 7, 0, 11.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toUpperCase(),
                    style: AppTextStyle.title.copyWith(letterSpacing: 3),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyL,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: QuantityWidget(
                      product: product,
                      onUpdateQuantity: onUpdateQuantity,
                    ),
                  ),
                  Text(
                    SessionUtils.priceDisplay(product.price),
                    style: AppTextStyle.price,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

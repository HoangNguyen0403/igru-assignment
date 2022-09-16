// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../repositories/products/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool displayFavoriteButton;
  const ProductCard({
    required this.product,
    this.displayFavoriteButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(
                      child: CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                if (displayFavoriteButton) _FavoriteButton(product: product),
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
            NumberFormat.currency(
              symbol: "\$",
              decimalDigits: 2,
            ).format(product.price),
            style: AppTextStyle.price,
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  final Product product;
  const _FavoriteButton({required this.product, Key? key}) : super(key: key);

  @override
  State<_FavoriteButton> createState() => __FavoriteButtonState();
}

class __FavoriteButtonState extends State<_FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.product.isFavorited;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: IconButton(
        onPressed: () {
          isFavorite = !isFavorite;
          setState(() {});
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_outline,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

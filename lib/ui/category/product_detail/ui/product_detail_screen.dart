// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../repositories/products/models/product.dart';
import '../../../../utils/multi-languages/multi_languages_utils.dart';
import '../../../../utils/route/app_routing.dart';
import '../../../../utils/session_utils.dart';
import '../../../checkout/checkout_route.dart';
import '../../../common/widgets/common_appbar.dart';
import '../../../common/widgets/common_button.dart';
import 'carousel_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product productSelected;
  const ProductDetailScreen({required this.productSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: CarouselProduct(product: productSelected),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productSelected.name.toUpperCase(),
                    style: AppTextStyle.title.copyWith(letterSpacing: 3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    SessionUtils.priceDisplay(productSelected.price),
                    style: AppTextStyle.price,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productSelected.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyL,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      key: const Key("addToCart"),
                      onTap: () {
                        SessionUtils.addProductToCart(productSelected);
                      },
                      title: LocaleKeys.addToCart.tr(),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Assets.icons.shoppingBag
                            .svg(color: AppColors.offWhite),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CommonButton(
                      key: const Key("checkout"),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteDefine.checkoutScreen.name,
                          arguments: CheckoutArgs(products: [productSelected]),
                        );
                      },
                      title: LocaleKeys.checkout.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

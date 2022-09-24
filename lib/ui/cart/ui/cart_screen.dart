// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';
import '../../../utils/route/app_routing.dart';
import '../../../utils/session_utils.dart';
import '../../checkout/checkout_route.dart';
import '../../common/widgets/common_appbar.dart';
import '../../common/widgets/common_button.dart';
import '../../common/widgets/product_with_quantity_widget.dart';
import '../bloc/bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(displayCartIcon: false),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is LoadedProducts) {
              if (state.products.isEmpty) {
                return Center(child: Assets.images.emptyCart.image());
              }

              return Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Dismissible(
                              key: Key(state.products[index].id.toString()),
                              onDismissed: ((direction) {
                                context
                                    .read<CartBloc>()
                                    .add(DismissProduct(index));
                              }),
                              direction: DismissDirection.endToStart,
                              background: Container(color: Colors.red),
                              child: ProductWithQuantity(
                                product: state.products[index],
                                onUpdateQuantity: (quantity) {
                                  context.read<CartBloc>().add(
                                        ChangeQuantityPressed(
                                          quantity,
                                          state.products[index].id,
                                        ),
                                      );
                                },
                              ),
                            ),
                            childCount: state.products.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.total.tr().toUpperCase(),
                          style: AppTextStyle.title.copyWith(letterSpacing: 3),
                        ),
                        Text(
                          SessionUtils.priceDisplay(
                            state.products.fold(
                              0,
                              (previousValue, product) =>
                                  previousValue + product.priceWithQuantity,
                            ),
                          ),
                          style: AppTextStyle.price,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CommonButton(
                    title: LocaleKeys.buyNow.tr(),
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Assets.icons.shoppingBag
                          .svg(color: AppColors.offWhite),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteDefine.checkoutScreen.name,
                        arguments: CheckoutArgs(
                          products: state.products,
                          isClearCart: true,
                        ),
                      );
                    },
                    borderRadius: 0,
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

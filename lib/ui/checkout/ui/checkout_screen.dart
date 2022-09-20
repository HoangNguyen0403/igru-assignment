// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../repositories/products/models/product.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';
import '../../../utils/session_utils.dart';
import '../../common/widgets/common_appbar.dart';
import '../../common/widgets/common_button.dart';
import '../bloc/bloc/checkout_bloc.dart';
import 'checkout_item_widget.dart';
import 'delivery_address_section.dart';
import 'payment_success_dialog.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> products;
  const CheckoutScreen({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 35.h),
          Text(
            LocaleKeys.checkout.tr().toUpperCase(),
            style: AppTextStyle.title.copyWith(letterSpacing: 3),
          ),
          Assets.icons.divider.svg(),
          const DeliveryAddressSection(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  CheckoutItem(product: products[index]),
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.checkout.tr().toUpperCase(),
                  style: AppTextStyle.title.copyWith(letterSpacing: 3),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  buildWhen: (_, current) => current is CalculatedTotalState,
                  builder: (context, state) {
                    final double totalPrice = state is CalculatedTotalState
                        ? state.products.fold(
                            0,
                            (previousValue, product) =>
                                previousValue + product.priceWithQuantity,
                          )
                        : 0;

                    return Text(
                      SessionUtils.priceDisplay(totalPrice),
                      style: AppTextStyle.price,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 22.h),
          CommonButton(
            title: LocaleKeys.checkout.tr(),
            icon: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Assets.icons.shoppingBag.svg(color: AppColors.offWhite),
            ),
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const PaymentSuccessDialog(),
              );
            },
            borderRadius: 0,
          ),
        ],
      ),
    );
  }
}

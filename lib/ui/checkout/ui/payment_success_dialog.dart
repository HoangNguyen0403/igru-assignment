// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';
import '../../../utils/route/app_routing.dart';
import '../../../utils/session_utils.dart';
import '../../common/widgets/common_button.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final bool canClearCart;
  const PaymentSuccessDialog({this.canClearCart = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 500.h,
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text(
              LocaleKeys.paymentSuccess.tr().toUpperCase(),
              style: AppTextStyle.title.copyWith(letterSpacing: 3),
            ),
            SizedBox(height: 28.h),
            Assets.icons.paymentSuccessIcon.svg(),
            SizedBox(height: 40.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.paymentSuccessDescription.tr(),
                    style: AppTextStyle.title.copyWith(
                      color: AppColors.body,
                    ),
                  ),
                  TextSpan(
                    text: LocaleKeys.paymentId.tr(namedArgs: {'id': "123312"}),
                    style: AppTextStyle.price.copyWith(
                      color: AppColors.body,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Assets.icons.divider.svg(),
            const Spacer(),
            CommonButton(
              title: LocaleKeys.backToHome.tr().toUpperCase(),
              onTap: () {
                if (canClearCart) {
                  SessionUtils.clearCart();
                }
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteDefine.homeScreen.name,
                  (route) => false,
                );
              },
              borderRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}

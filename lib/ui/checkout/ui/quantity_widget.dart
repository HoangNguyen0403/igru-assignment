// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../repositories/products/models/product.dart';
import '../bloc/bloc/checkout_bloc.dart';

class QuantityWidget extends StatefulWidget {
  final Product product;
  const QuantityWidget({required this.product, super.key});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int currentQuantity = 1;

  @override
  void initState() {
    currentQuantity = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (currentQuantity > 1) {
              _changeQuantityPressed();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.quantityBorder,
              ),
              color: currentQuantity == 1
                  ? AppColors.background
                  : AppColors.offWhite,
            ),
            margin: EdgeInsets.only(right: 13.w),
            child: const Icon(
              Icons.remove,
              color: AppColors.label,
            ),
          ),
        ),
        Text(
          currentQuantity.toString(),
          style: AppTextStyle.title,
        ),
        GestureDetector(
          onTap: () {
            _changeQuantityPressed(isIncrease: true);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.quantityBorder,
              ),
            ),
            margin: EdgeInsets.only(left: 13.w),
            child: const Icon(
              Icons.add,
              color: AppColors.label,
            ),
          ),
        ),
      ],
    );
  }

  void _changeQuantityPressed({bool isIncrease = false}) {
    isIncrease ? currentQuantity++ : currentQuantity--;
    context.read<CheckoutBloc>().add(
          ChangeQuantityPressed(
            currentQuantity,
            widget.product.id,
          ),
        );
    setState(() {});
  }
}

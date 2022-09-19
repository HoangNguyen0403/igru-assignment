// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final VoidCallback onTap;
  final double borderRadius;
  const CommonButton({
    required this.title,
    required this.onTap,
    this.borderRadius = 8,
    this.icon,
    super.key,
  });

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
        backgroundColor: AppColors.titleActive,
        textStyle: AppTextStyle.bodyL.copyWith(color: AppColors.offWhite),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  Widget get _title => Text(
        title.toUpperCase(),
      );
  @override
  Widget build(BuildContext context) {
    return icon != null
        ? ElevatedButton.icon(
            onPressed: onTap,
            icon: icon!,
            style: _buttonStyle,
            label: _title,
          )
        : ElevatedButton(
            onPressed: onTap,
            style: _buttonStyle,
            child: _title,
          );
  }
}

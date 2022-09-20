// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/styles.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';

class DeliveryAddressSection extends StatefulWidget {
  const DeliveryAddressSection({super.key});

  @override
  State<DeliveryAddressSection> createState() => _DeliveryAddressSectionState();
}

class _DeliveryAddressSectionState extends State<DeliveryAddressSection> {
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: LocaleKeys.deliveryAddress.tr(),
              hintText: LocaleKeys.addressHint.tr(),
              hintStyle: AppTextStyle.bodyL,
            ),
            style: AppTextStyle.subTitle16,
          ),
          SizedBox(height: 30.h),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: LocaleKeys.note.tr(),
              hintStyle: AppTextStyle.bodyL,
            ),
            style: AppTextStyle.subTitle16,
          ),
        ],
      ),
    );
  }
}

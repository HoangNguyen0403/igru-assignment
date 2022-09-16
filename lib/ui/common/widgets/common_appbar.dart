// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../gen/assets.gen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBG,
      title: Assets.images.logo.svg(),
      centerTitle: true,
      actions: [
        Assets.icons.search.svg(),
        Padding(
          padding: EdgeInsets.only(right: 23.w, left: 16.w),
          child: Assets.icons.shoppingBag.svg(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

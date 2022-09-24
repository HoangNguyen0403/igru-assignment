// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../database/hive_manager.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/route/app_routing.dart';
import '../../../utils/session_utils.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool displayCartIcon;
  const CommonAppBar({this.displayCartIcon = true, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBG,
      iconTheme: const IconThemeData(color: AppColors.titleActive),
      title: Assets.images.logo.svg(),
      centerTitle: true,
      actions: [
        if (displayCartIcon)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteDefine.cartScreen.name);
            },
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 23.w, left: 16.w, top: 15.h),
                  child: Assets.icons.shoppingBag.svg(),
                ),
                Positioned(
                  right: 15,
                  top: 0,
                  child: ValueListenableBuilder<Box>(
                    valueListenable:
                        Hive.box(HiveBoxKey.products.name).listenable(),
                    builder: (context, value, child) {
                      return SessionUtils.getProductFromDB().isEmpty
                          ? const SizedBox()
                          : Container(
                              key: const Key("cartNumber"),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.offWhite,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                SessionUtils.getProductFromDB()
                                    .length
                                    .toString(),
                                style: AppTextStyle.bodyM
                                    .copyWith(color: AppColors.primary),
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

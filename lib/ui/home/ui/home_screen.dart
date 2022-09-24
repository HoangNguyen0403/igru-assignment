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
import '../../../utils/route/app_routing.dart';
import '../../common/widgets/common_appbar.dart';
import '../../common/widgets/products_gridview.dart';
import '../bloc/bloc/home_bloc.dart';

enum Category {
  all,
  apparel,
  dress,
  tshirt,
  bag,
}

extension CategoryExt on Category {
  ProductType? get productTypeFilter {
    return this == Category.all ? null : ProductType.values.byName(name);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category category = Category.all;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Category.values.length,
      child: SafeArea(
        child: Scaffold(
          appBar: const CommonAppBar(),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 35.h),
                Text(
                  LocaleKeys.homeTitle.tr().toUpperCase(),
                  style: AppTextStyle.title.copyWith(letterSpacing: 3),
                ),
                Assets.icons.divider.svg(),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBar(
                    tabs: Category.values
                        .map(
                          (category) => Tab(
                            key: Key(category.name.toLowerCase()),
                            text: category.name.toLowerCase().tr(),
                          ),
                        )
                        .toList(),
                    onTap: ((index) {
                      category = Category.values[index];
                      context.read<HomeBloc>().add(
                            LoadProducts(
                              productType: category.productTypeFilter,
                            ),
                          );
                    }),
                    labelStyle: AppTextStyle.subTitle14,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(bottom: 10.h),
                    labelPadding: EdgeInsets.zero,
                    labelColor: AppColors.titleTextColor,
                    unselectedLabelColor: AppColors.placeHolder,
                    unselectedLabelStyle: AppTextStyle.subTitle14.copyWith(
                      color: AppColors.placeHolder,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (_, current) => current is ProductLoaded,
                    builder: (context, state) {
                      if (state is ProductLoaded) {
                        return CustomScrollView(
                          slivers: [
                            ProductGridView(
                              products: state.categoryModel.products,
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  key: const Key('exploreMore'),
                  onTap: (() {
                    Navigator.pushNamed(
                      context,
                      RouteDefine.categoryListScreen.name,
                      arguments: category,
                    );
                  }),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.exploreMore.tr(),
                        style: AppTextStyle.title,
                      ),
                      SizedBox(width: 5.w),
                      Assets.icons.nextArrow.svg(),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Assets.icons.divider.svg(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

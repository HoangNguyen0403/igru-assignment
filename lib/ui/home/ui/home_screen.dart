import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/styles.dart';
import '../../../repositories/products/models/product.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';
import '../../../config/colors.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Category {
  all,
  apparel,
  dress,
  tshirt,
  bag,
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
      child: Scaffold(
        appBar: AppBar(
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
        ),
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
                          text: category.name.toLowerCase().tr(),
                        ),
                      )
                      .toList(),
                  onTap: ((value) {
                    context.read<HomeBloc>().add(
                          LoadProducts(
                            productType: value == 0
                                ? null
                                : ProductType.values.byName(
                                    Category.values[value].name,
                                  ),
                          ),
                        );
                  }),
                  labelStyle: AppTextStyle.subTitle14,
                  indicatorPadding: EdgeInsets.only(bottom: 10.h),
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
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w,
                          mainAxisExtent: 240.h,
                        ),
                        itemCount: state.categoryModel.products.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              color: AppColors.dark,
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Row(
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
              SizedBox(height: 20.h),
              Assets.icons.divider.svg(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

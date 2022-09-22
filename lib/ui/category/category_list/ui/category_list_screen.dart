// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../common/dialog/loading_dialog.dart';
import '../../../common/widgets/common_appbar.dart';
import '../../../common/widgets/products_gridview.dart';
import '../../../home/ui/home_screen.dart';
import '../bloc/bloc/category_list_bloc.dart';

class CategoryListScreen extends StatelessWidget {
  final Category category;
  const CategoryListScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            BlocConsumer<CategoryListBloc, CategoryListState>(
              listener: (context, state) {
                if (state is ProductLoading) {
                  LoadingDialog.showLoadingDialog(context);
                } else {
                  LoadingDialog.hideLoadingDialog;
                }
              },
              buildWhen: (_, current) => current is CategoryProductLoaded,
              builder: (_, state) {
                if (state is CategoryProductLoaded) {
                  return Expanded(
                    child: ProductGridView(
                      products: state.products,
                      displayFavorite: true,
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

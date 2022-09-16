// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../repositories/products/product_repository.dart';
import '../../../utils/di/injection.dart';
import '../../home/ui/home_screen.dart';
import 'bloc/bloc/category_list_bloc.dart';
import 'ui/category_list_screen.dart';

class CategoryListRoute {
  static Widget route({Category category = Category.all}) => BlocProvider(
        create: (context) => CategoryListBloc(getIt<ProductRepository>())
          ..add(LoadProducts(productType: category.productTypeFilter)),
        child: CategoryListScreen(category: category),
      );
}

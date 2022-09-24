// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../repositories/products/models/product.dart';
import '../../../../repositories/products/product_repository.dart';
import '../../model/category_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository repository;
  final List<CategoryModel> categorySet = [];
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());

      final result = await repository.getProducts(
        productType: event.productType,
        totalItems: 4,
      );

      final int indexCategory = categorySet
          .indexWhere((category) => category.type == event.productType);
      if (indexCategory == -1) {
        final categoryNew =
            CategoryModel(products: result, type: event.productType);
        categorySet.add(categoryNew);

        emit(ProductLoaded(categoryNew));
      } else {
        categorySet[indexCategory] =
            categorySet[indexCategory].copyWith(result);

        emit(ProductLoaded(categorySet[indexCategory]));
      }
    });
  }
}

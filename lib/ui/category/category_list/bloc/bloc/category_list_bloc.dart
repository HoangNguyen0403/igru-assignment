// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../../repositories/products/models/product.dart';
import '../../../../../repositories/products/product_repository.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final ProductRepository repository;
  final List<Product> products = [];

  CategoryListBloc(this.repository) : super(CategoryListInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());

      final result = await repository.getProducts(
        productType: event.productType,
      );
      products.clear();
      products.addAll(result);

      emit(CategoryProductLoaded(products));
    });
  }
}

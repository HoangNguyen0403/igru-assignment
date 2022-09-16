part of 'category_list_bloc.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();

  @override
  List<Object> get props => [];
}

class CategoryListInitial extends CategoryListState {}

class ProductLoading extends CategoryListState {}

class CategoryProductLoaded extends CategoryListState {
  final List<Product> products;

  const CategoryProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

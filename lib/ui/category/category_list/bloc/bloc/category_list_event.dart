part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends CategoryListEvent {
  final ProductType? productType;

  const LoadProducts({this.productType});
}

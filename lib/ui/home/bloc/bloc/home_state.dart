part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ProductLoading extends HomeState {}

class ProductLoaded extends HomeState {
  final CategoryModel categoryModel;

  const ProductLoaded(this.categoryModel);

  @override
  List<Object> get props => [categoryModel];
}

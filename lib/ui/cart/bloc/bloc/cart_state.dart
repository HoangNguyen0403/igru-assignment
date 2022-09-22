part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class LoadedProducts extends CartState {
  final List<Product> products;

  const LoadedProducts(this.products);

  @override
  List<Object> get props => [products];
}

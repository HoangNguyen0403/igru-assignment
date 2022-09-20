part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CalculatedTotalState extends CheckoutState {
  final List<Product> products;

  const CalculatedTotalState(this.products);

  @override
  List<Object> get props => [products];
}

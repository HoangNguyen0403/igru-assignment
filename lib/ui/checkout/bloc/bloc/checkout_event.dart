part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class ChangeQuantityPressed extends CheckoutEvent {
  final int newQuantity;
  final int productId;

  const ChangeQuantityPressed(this.newQuantity, this.productId);

  @override
  List<Object> get props => [
        newQuantity,
        productId,
      ];
}

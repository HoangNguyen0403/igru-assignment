part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class ChangeQuantityPressed extends CartEvent {
  final int newQuantity;
  final int productId;

  const ChangeQuantityPressed(this.newQuantity, this.productId);

  @override
  List<Object> get props => [
        newQuantity,
        productId,
      ];
}

class DismissProduct extends CartEvent {
  final int productIndex;

  const DismissProduct(this.productIndex);
  @override
  List<Object> get props => [productIndex];
}

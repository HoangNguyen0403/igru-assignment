part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends HomeEvent {
  final ProductType? productType;

  const LoadProducts({this.productType});
}

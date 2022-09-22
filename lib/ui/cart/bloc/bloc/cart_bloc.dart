// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../repositories/products/models/product.dart';
import '../../../../utils/session_utils.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<Product> products = [];

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) {
      products.clear();
      products.addAll(SessionUtils.getProductFromDB());
      emit(LoadedProducts(products));
    });
    on<ChangeQuantityPressed>((event, emit) {
      emit(CartInitial());
      final index =
          products.indexWhere((product) => product.id == event.productId);

      if (index != -1) {
        products[index] = products[index].copyWith(quantity: event.newQuantity);
        emit(LoadedProducts(products));
      }
    });
    on<DismissProduct>((event, emit) {
      emit(CartInitial());
      SessionUtils.removeProductFromDB(products[event.productIndex]);
      products.removeAt(event.productIndex);
      emit(LoadedProducts(products));
    });
  }
}

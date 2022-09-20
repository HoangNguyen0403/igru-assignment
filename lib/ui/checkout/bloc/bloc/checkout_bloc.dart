// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../repositories/products/models/product.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final List<Product> products;
  CheckoutBloc(this.products) : super(CalculatedTotalState(products)) {
    on<ChangeQuantityPressed>((event, emit) {
      emit(CheckoutInitial());
      final index =
          products.indexWhere((product) => product.id == event.productId);

      if (index != -1) {
        products[index] = products[index].copyWith(quantity: event.newQuantity);
        emit(CalculatedTotalState(products));
      }
    });
  }
}

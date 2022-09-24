// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:igru_assignment/repositories/products/models/product.dart';
import 'package:igru_assignment/ui/checkout/bloc/bloc/checkout_bloc.dart';
import '../../utilities/utility.dart';

void main() {
  final List<Product> products = Utility.mockProducts;
  group('Checkout Bloc', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'Change quantity first item in list',
      build: () => CheckoutBloc(products),
      setUp: () {
        products.first = products.first.copyWith(quantity: 2);
      },
      act: (bloc) => bloc.add(const ChangeQuantityPressed(2, 4)),
      expect: () => [
        CheckoutInitial(),
        CalculatedTotalState(products),
      ],
      verify: (bloc) {
        expect(bloc.products.first.quantity, 2);
      },
    );
  });
}

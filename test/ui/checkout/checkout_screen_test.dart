// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:igru_assignment/repositories/products/product_repository.dart';
import 'package:igru_assignment/ui/checkout/bloc/bloc/checkout_bloc.dart';
import 'package:igru_assignment/ui/checkout/checkout_route.dart';
import 'package:igru_assignment/ui/checkout/ui/checkout_screen.dart';
import 'package:igru_assignment/ui/checkout/ui/payment_success_dialog.dart';
import 'package:igru_assignment/ui/common/widgets/product_with_quantity_widget.dart';
import 'package:igru_assignment/utils/di/injection.dart';
import 'package:igru_assignment/utils/session_utils.dart';
import '../../utilities/mock_utility.dart';
import '../../utilities/test_utilitiy.dart';
import '../../utilities/utility.dart';

void main() {
  final CheckoutBloc checkoutBlocMock = CheckoutBlocMock();
  final checkoutArgs =
      CheckoutArgs(products: Utility.mockProducts, isClearCart: true);
  final repoMock = ProductRepositoryMock();

  setUpAll(() async {
    await Utility.mockHive("checkout");
    getIt.registerSingleton<ProductRepository>(repoMock);
  });

  group("Checkout Screen", () {
    testWidgets("Load products while create screen", (tester) async {
      Utility.setScreenForTest(tester);

      when(() => checkoutBlocMock.products).thenReturn(checkoutArgs.products);
      whenListen<CheckoutState>(
        checkoutBlocMock,
        Stream.fromIterable([CalculatedTotalState(checkoutArgs.products)]),
      );
      when(() => checkoutBlocMock.state)
          .thenReturn(CalculatedTotalState(checkoutArgs.products));
      when(() => checkoutBlocMock.close())
          .thenAnswer((invocation) async => Future.value);

      await tester.pumpWidget(
        TestWidgetWrapper(
          child: BlocProvider(
            create: (context) => checkoutBlocMock,
            child: CheckoutScreen(args: checkoutArgs),
          ),
        ),
      );

      final productWithQuantity = find.byType(ProductWithQuantity);
      final String totalPriceText = SessionUtils.priceDisplay(
        checkoutArgs.products.fold(
          0,
          (previousValue, product) => previousValue + product.priceWithQuantity,
        ),
      );
      final totalPrice = find.text(totalPriceText);

      expect(productWithQuantity, findsNWidgets(checkoutArgs.products.length));
      expect(totalPrice, findsOneWidget);
    });

    testWidgets(
      "Load products while create screen then click checkout",
      (tester) async {
        Utility.setScreenForTest(tester);

        when(() => checkoutBlocMock.products).thenReturn(checkoutArgs.products);
        whenListen<CheckoutState>(
          checkoutBlocMock,
          Stream.fromIterable([CalculatedTotalState(checkoutArgs.products)]),
        );
        when(() => checkoutBlocMock.state)
            .thenReturn(CalculatedTotalState(checkoutArgs.products));
        when(() => checkoutBlocMock.close())
            .thenAnswer((invocation) async => Future.value);

        await tester.pumpWidget(
          TestWidgetWrapper(
            child: BlocProvider(
              create: (context) => checkoutBlocMock,
              child: CheckoutScreen(args: checkoutArgs),
            ),
          ),
        );

        final productWithQuantity = find.byType(ProductWithQuantity);
        final String totalPriceText = SessionUtils.priceDisplay(
          checkoutArgs.products.fold(
            0,
            (previousValue, product) =>
                previousValue + product.priceWithQuantity,
          ),
        );
        final totalPrice = find.text(totalPriceText);

        expect(
          productWithQuantity,
          findsNWidgets(checkoutArgs.products.length),
        );
        expect(totalPrice, findsOneWidget);

        final checkoutButton = find.byKey(const Key("checkout"));
        final paymentDialog = find.byType(PaymentSuccessDialog);

        await tester.tap(checkoutButton);
        await tester.pump();
        await tester.pump();

        expect(paymentDialog, findsOneWidget);
      },
    );
  });
}

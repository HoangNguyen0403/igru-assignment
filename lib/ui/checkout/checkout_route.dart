// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../repositories/products/models/product.dart';
import 'bloc/bloc/checkout_bloc.dart';
import 'ui/checkout_screen.dart';

class CheckoutRoute {
  static Widget route(List<Product> products) => BlocProvider(
        create: (context) => CheckoutBloc(products),
        child: CheckoutScreen(products: products),
      );
}

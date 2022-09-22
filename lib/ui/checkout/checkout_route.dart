// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../repositories/products/models/product.dart';
import 'bloc/bloc/checkout_bloc.dart';
import 'ui/checkout_screen.dart';

class CheckoutArgs {
  final List<Product> products;
  final bool isClearCart;

  CheckoutArgs({required this.products, this.isClearCart = false});
}

class CheckoutRoute {
  static Widget route(CheckoutArgs args) => BlocProvider(
        create: (context) => CheckoutBloc(args.products),
        child: CheckoutScreen(args: args),
      );
}

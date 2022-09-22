// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'bloc/bloc/cart_bloc.dart';
import 'ui/cart_screen.dart';

class CartRoute {
  static Widget get route => BlocProvider(
        create: (context) => CartBloc()..add(LoadCart()),
        child: const CartScreen(),
      );
}

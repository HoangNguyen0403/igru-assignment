// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../repositories/products/product_repository.dart';
import '../../utils/di/injection.dart';
import 'bloc/bloc/home_bloc.dart';
import 'ui/home_screen.dart';

class HomeRoute {
  static Widget get route => BlocProvider(
        create: (context) => HomeBloc(getIt<ProductRepository>())
          ..add(
            const LoadProducts(),
          ),
        child: HomeScreen(),
      );
}

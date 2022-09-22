// Package imports:
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// Project imports:
import 'package:igru_assignment/repositories/products/product_repository.dart';
import 'package:igru_assignment/ui/home/bloc/bloc/home_bloc.dart';

class ProductRepositoryMock extends Mock implements ProductRepository {}

class HomeBlocMock extends Mock implements HomeBloc {}

class PathProviderMock extends Mock implements PlatformInterface {}

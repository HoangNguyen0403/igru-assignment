// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:igru_assignment/gen/assets.gen.dart';
import 'package:igru_assignment/repositories/products/models/product.dart';
import 'package:igru_assignment/ui/home/bloc/bloc/home_bloc.dart';
import 'package:igru_assignment/ui/home/model/category_model.dart';
import '../../utilities/mock_utility.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final repoMock = ProductRepositoryMock();
  List<dynamic> response = [];
  List<Product> products = [];
  const mockProductType = ProductType.bag;

  setUpAll(() async {
    response = jsonDecode(
      await rootBundle.loadString(Assets.json.productResponse),
    );
  });
  group('Home Bloc', () {
    blocTest<HomeBloc, HomeState>(
      'Load all Products type event',
      build: () => HomeBloc(repoMock),
      act: (bloc) => bloc.add(const LoadProducts()),
      setUp: () {
        products = response
            .map((product) => Product.fromJson(product))
            .take(5)
            .toList();

        when(() => repoMock.getProducts(totalItems: 4))
            .thenAnswer((invocation) async => products);
      },
      expect: () => [
        ProductLoading(),
        ProductLoaded(
          CategoryModel(
            products: products,
          ),
        ),
      ],
      verify: (bloc) {
        expect(bloc.categorySet.length, 1);
        expect(bloc.categorySet.first.products.length <= 5, true);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Load all Products specific type event',
      build: () => HomeBloc(repoMock),
      act: (bloc) => bloc.add(const LoadProducts(productType: mockProductType)),
      setUp: () {
        products = response
            .map((product) => Product.fromJson(product))
            .where((product) => product.productType == mockProductType)
            .take(5)
            .toList();

        when(
          () => repoMock.getProducts(
            totalItems: 4,
            productType: mockProductType,
          ),
        ).thenAnswer((invocation) async => products);
      },
      expect: () => [
        ProductLoading(),
        ProductLoaded(
          CategoryModel(
            products: products,
            type: mockProductType,
          ),
        ),
      ],
      verify: (bloc) {
        expect(bloc.categorySet.length, 1);
        expect(bloc.categorySet.first.type, mockProductType);

        expect(bloc.categorySet.first.products.length <= 5, true);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Load all Products specific type event and reload this type again',
      build: () => HomeBloc(repoMock),
      act: (bloc) => bloc
        ..add(const LoadProducts(productType: mockProductType))
        ..add(const LoadProducts(productType: mockProductType)),
      setUp: () {
        products = response
            .map((product) => Product.fromJson(product))
            .where((product) => product.productType == mockProductType)
            .take(5)
            .toList();

        when(
          () => repoMock.getProducts(
            totalItems: 4,
            productType: mockProductType,
          ),
        ).thenAnswer((invocation) async => products);
      },
      expect: () => [
        ProductLoading(),
        ProductLoaded(
          CategoryModel(
            products: products,
            type: mockProductType,
          ),
        ),
        ProductLoading(),
        ProductLoaded(
          CategoryModel(
            products: products,
            type: mockProductType,
          ),
        ),
      ],
      verify: (bloc) {
        expect(bloc.categorySet.length, 1);
        expect(bloc.categorySet.first.type, mockProductType);

        expect(bloc.categorySet.first.products.length <= 5, true);
      },
    );
  });
}

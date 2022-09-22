// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

// Project imports:
import 'package:igru_assignment/database/hive_manager.dart';
import 'package:igru_assignment/gen/assets.gen.dart';
import 'package:igru_assignment/repositories/products/models/product.dart';
import 'package:igru_assignment/repositories/products/product_repository.dart';
import 'package:igru_assignment/ui/category/category_list/ui/category_list_screen.dart';
import 'package:igru_assignment/ui/common/widgets/products_gridview.dart';
import 'package:igru_assignment/ui/home/bloc/bloc/home_bloc.dart';
import 'package:igru_assignment/ui/home/model/category_model.dart';
import 'package:igru_assignment/ui/home/ui/home_screen.dart';
import 'package:igru_assignment/utils/di/injection.dart';
import '../../utilities/mock_utility.dart';
import '../../utilities/path_provider_mock.dart';
import '../../utilities/test_utilitiy.dart';

void main() {
  final HomeBloc homeBlocMock = HomeBlocMock();
  List<dynamic> response = [];
  List<Product> products = [];
  final ProductRepository repoMock = ProductRepositoryMock();
  const mockProductType = ProductType.bag;

  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    getIt.registerSingleton(HiveManager());
    getIt.registerSingleton<ProductRepository>(repoMock);

    when(() => repoMock.getProducts()).thenAnswer((invocation) async => []);
    response = jsonDecode(
      await rootBundle.loadString(Assets.json.productResponse),
    );
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxKey.products.name);
  });

  group("Home Screen", () {
    testWidgets('Home Screen with load all products', (tester) async {
      products =
          response.map((product) => Product.fromJson(product)).take(5).toList();

      whenListen<HomeState>(
        homeBlocMock,
        Stream.fromIterable([ProductLoaded(CategoryModel(products: products))]),
        initialState: HomeInitial(),
      );
      when(() => homeBlocMock.state)
          .thenReturn(ProductLoaded(CategoryModel(products: products)));

      when(() => homeBlocMock.close())
          .thenAnswer((invocation) async => Future.value);

      await tester.pumpWidget(
        TestWidgetWrapper(
          child: BlocProvider(
            create: (context) => homeBlocMock,
            child: HomeScreen(),
          ),
        ),
      );

      final tabs = find.byType(Tab);
      final gridView = find.byType(ProductGridView);
      expect(tabs, findsNWidgets(5));
      expect(gridView, findsOneWidget);
    });

    testWidgets(
      'Home Screen with load all products then click category list screen',
      (tester) async {
        products = response
            .map((product) => Product.fromJson(product))
            .take(5)
            .toList();

        whenListen<HomeState>(
          homeBlocMock,
          Stream.fromIterable(
            [
              ProductLoaded(
                CategoryModel(products: products),
              ),
            ],
          ),
          initialState: HomeInitial(),
        );
        when(() => homeBlocMock.state)
            .thenReturn(ProductLoaded(CategoryModel(products: products)));

        when(() => homeBlocMock.close())
            .thenAnswer((invocation) async => Future.value);

        await tester.pumpWidget(
          TestWidgetWrapper(
            child: BlocProvider(
              create: (context) => homeBlocMock,
              child: HomeScreen(),
            ),
          ),
        );

        final tabs = find.byType(Tab);
        final gridView = find.byType(ProductGridView);
        final exploreMore = find.byKey(const Key("exploreMore"));
        final categoryScreen = find.byType(CategoryListScreen);

        expect(tabs, findsNWidgets(5));
        expect(gridView, findsOneWidget);

        await tester.tap(exploreMore);
        await tester.pumpAndSettle();

        expect(tabs, findsNothing);
        expect(categoryScreen, findsOneWidget);
      },
    );

    testWidgets(
      'Home Screen with load all products then change tab',
      (tester) async {
        products = response
            .map((product) => Product.fromJson(product))
            .take(5)
            .toList();

        whenListen<HomeState>(
          homeBlocMock,
          Stream.fromIterable(
            [
              ProductLoaded(
                CategoryModel(products: products),
              ),
            ],
          ),
          initialState: HomeInitial(),
        );
        when(() => homeBlocMock.state)
            .thenReturn(ProductLoaded(CategoryModel(products: products)));

        when(() => homeBlocMock.close())
            .thenAnswer((invocation) async => Future.value);

        await tester.pumpWidget(
          TestWidgetWrapper(
            child: BlocProvider(
              create: (context) => homeBlocMock,
              child: HomeScreen(),
            ),
          ),
        );

        final tabs = find.byType(Tab);
        final gridView = find.byType(ProductGridView);
        final bagsTab = find.byKey(Key(Category.bag.name.toLowerCase()));

        expect(tabs, findsNWidgets(5));
        expect(gridView, findsOneWidget);

        await tester.tap(bagsTab);
        await tester.pump();

        products = response
            .map((product) => Product.fromJson(product))
            .where((product) => product.productType == mockProductType)
            .take(5)
            .toList();

        whenListen<HomeState>(
          homeBlocMock,
          Stream.fromIterable(
            [
              ProductLoaded(
                CategoryModel(products: products, type: mockProductType),
              ),
            ],
          ),
          initialState: HomeInitial(),
        );
        when(() => homeBlocMock.state).thenReturn(
          ProductLoaded(
            CategoryModel(
              products: products,
              type: mockProductType,
            ),
          ),
        );

        expect(tabs, findsNWidgets(5));
        expect(gridView, findsOneWidget);
      },
    );
  });
}

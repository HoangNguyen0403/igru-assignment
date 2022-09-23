import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:igru_assignment/repositories/products/models/product.dart';
import 'package:igru_assignment/ui/category/product_detail/ui/carousel_widget.dart';
import 'package:igru_assignment/ui/category/product_detail/ui/product_detail_screen.dart';
import 'package:igru_assignment/utils/session_utils.dart';

import '../../utilities/test_utilitiy.dart';
import '../../utilities/utility.dart';

void main() {
  final Product mockProduct = Product.fromJson(
    const {
      "id": 2,
      "name": "Dress for lady",
      "price": 128.4,
      "imageUrl": "https://picsum.photos/id/1/5616/3744",
      "description":
          "This dress is made of a light and airy fabric that will feel like a cloud on your skin. It has a loose, romantic shape with flowing sleeves and a draping back. The front has a band of lace that runs across the bodice and then falls down the side of the dress. The lace band also has a ruffle in the center, with a delicate floral pattern.",
      "selected": false,
      "productType": "dress",
      "imagesDetail": [
        "https://picsum.photos/id/0/5616/3744",
        "https://picsum.photos/id/115/1500/1000",
        "https://picsum.photos/id/114/3264/2448",
      ],
    },
  );

  setUpAll(() async {
    await Utility.mockHive("product-detail");
  });

  tearDownAll(() async {
    await Utility.unMockHive();
  });
  group("Product Detail", () {
    testWidgets("Test load product with mock product", (tester) async {
      const width = 411.4;
      const height = 797.7;
      tester.binding.window.devicePixelRatioTestValue = (2.625);
      final dpi = tester.binding.window.devicePixelRatio;
      tester.binding.window.physicalSizeTestValue =
          Size(width * dpi, height * dpi);

      await tester.pumpWidget(
        TestWidgetWrapper(
          child: ProductDetailScreen(
            productSelected: mockProduct,
          ),
        ),
      );

      final nameProduct = find.text(mockProduct.name.toUpperCase());
      final descriptionProduct = find.text(mockProduct.description);
      final priceProduct =
          find.text(SessionUtils.priceDisplay(mockProduct.price));

      final carouselWidget = find.byType(CarouselProduct);

      expect(nameProduct, findsOneWidget);
      expect(descriptionProduct, findsOneWidget);
      expect(priceProduct, findsOneWidget);
      expect(carouselWidget, findsOneWidget);
    });
  });
}

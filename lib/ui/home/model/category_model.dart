import '../../../repositories/products/models/product.dart';

class CategoryModel {
  ProductType? type;
  List<Product> products;

  CategoryModel({
    required this.products,
    this.type,
  });
}

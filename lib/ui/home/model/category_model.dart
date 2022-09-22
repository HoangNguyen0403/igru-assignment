// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../repositories/products/models/product.dart';

class CategoryModel extends Equatable {
  final ProductType? type;
  final List<Product> products;

  const CategoryModel({
    required this.products,
    this.type,
  });

  CategoryModel copyWith(List<Product>? products) =>
      CategoryModel(products: products ?? this.products, type: type);

  @override
  List<Object?> get props => [type, products];
}

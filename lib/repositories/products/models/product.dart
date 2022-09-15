import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

enum ProductType {
  apparel,
  dress,
  tshirt,
  bag,
}

@JsonSerializable()
class Product extends Equatable {
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final bool selected;
  final ProductType productType;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.productType,
    this.selected = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        name,
        price,
        imageUrl,
        description,
        selected,
      ];
}

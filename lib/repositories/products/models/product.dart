// Package imports:
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
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final bool selected;
  final ProductType productType;
  final bool isFavorited;
  final List<String> imagesDetail;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.productType,
    this.imagesDetail = const [],
    this.selected = false,
    this.isFavorited = false,
  });

  Product copyWith({
    bool? selected,
    bool? isFavorite,
  }) =>
      Product(
        id: id,
        name: name,
        price: price,
        imageUrl: imageUrl,
        description: description,
        productType: productType,
        selected: selected ?? this.selected,
        isFavorited: isFavorite ?? isFavorited,
        imagesDetail: imagesDetail,
      );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        imageUrl,
        description,
        selected,
        isFavorited,
        imagesDetail,
      ];
}

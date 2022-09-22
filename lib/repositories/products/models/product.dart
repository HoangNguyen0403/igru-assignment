// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import '../../../database/models/product_in_database.dart';
import '../../../utils/double_ext.dart';

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
  final ProductType productType;
  final bool isFavorited;
  final List<String> imagesDetail;
  final int quantity;

  double get priceWithQuantity => (price * quantity).roundNumber;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.productType,
    this.imagesDetail = const [],
    this.isFavorited = false,
    this.quantity = 1,
  });

  Product copyWith({
    bool? isFavorite,
    int? quantity,
  }) =>
      Product(
        id: id,
        name: name,
        price: price,
        imageUrl: imageUrl,
        description: description,
        productType: productType,
        isFavorited: isFavorite ?? isFavorited,
        imagesDetail: imagesDetail,
        quantity: quantity ?? this.quantity,
      );

  ProductInDatabase get productLocalDB => ProductInDatabase.fromJson(
        toJson()
          ..addAll(
            {
              'createAt': DateTime.now().toString(),
            },
          ),
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
        isFavorited,
        imagesDetail,
        quantity,
      ];
}

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import '../../repositories/products/models/product.dart';
import '../../utils/double_ext.dart';

part 'product_in_database.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ProductInDatabase extends Equatable {
  @HiveField(0)
  final int quantity;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime createAt;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final bool isFavorited;
  @HiveField(5)
  final String imageUrl;
  @HiveField(6)
  final double price;
  @HiveField(7)
  final String productType;
  @HiveField(8)
  final List<String> imagesDetail;
  @HiveField(9)
  final int id;

  double get priceWithQuantity => (price * quantity).roundNumber;

  const ProductInDatabase({
    required this.quantity,
    required this.name,
    required this.createAt,
    required this.description,
    required this.imageUrl,
    required this.isFavorited,
    required this.price,
    required this.imagesDetail,
    required this.productType,
    required this.id,
  });

  Product get productResponse => Product.fromJson(toJson());

  factory ProductInDatabase.fromJson(Map<String, dynamic> json) =>
      _$ProductInDatabaseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInDatabaseToJson(this);

  @override
  List<Object?> get props => [
        quantity,
        name,
        createAt,
        description,
        price,
        imageUrl,
        isFavorited,
        imagesDetail,
        productType,
      ];

  ProductInDatabase copyWith({
    int? quantity,
    DateTime? createAt,
    bool? isFavorited,
  }) =>
      ProductInDatabase(
        createAt: createAt ?? this.createAt,
        quantity: quantity ?? this.quantity,
        isFavorited: isFavorited ?? this.isFavorited,
        description: description,
        imageUrl: imageUrl,
        name: name,
        price: price,
        imagesDetail: imagesDetail,
        productType: productType,
        id: id,
      );
}

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../config/colors.dart';
import '../../../repositories/products/models/product.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;
  const FavoriteButton({required this.product, Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.product.isFavorited;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 8,
      child: IconButton(
        onPressed: () {
          isFavorite = !isFavorite;
          setState(() {});
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_outline,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../../config/colors.dart';
import '../../../../repositories/products/models/product.dart';

class CarouselProduct extends StatefulWidget {
  final Product product;
  const CarouselProduct({required this.product, super.key});

  @override
  State<CarouselProduct> createState() => _CarouselProductState();
}

class _CarouselProductState extends State<CarouselProduct> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: widget.product.imagesDetail.length,
              itemBuilder: (context, index, realIndex) {
                return CachedNetworkImage(
                  imageUrl: widget.product.imagesDetail[index],
                  cacheKey: widget.product.imagesDetail[index],
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.cover,
                );
              },
              options: CarouselOptions(
                height: 400.h,
                autoPlay: widget.product.imagesDetail.length > 1,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              carouselController: _controller,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.product.imagesDetail.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.placeHolder),
                    color: _current == entry.key
                        ? AppColors.placeHolder
                        : AppColors.greyBG,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

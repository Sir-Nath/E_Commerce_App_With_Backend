import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:get/get.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required double currentPageValue,
  }) : _currentPageValue = currentPageValue, super(key: key);

  final double _currentPageValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(
      builder: (popularProduct) {
        return DotsIndicator(
          dotsCount: popularProduct.popularProductList.isEmpty ? 1 : popularProduct.popularProductList.length,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        );
      }
    );
  }
}

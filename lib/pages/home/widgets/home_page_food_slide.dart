import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/models/popular_products_model.dart';
import 'package:full_e_commerce_app/routes/route_helper.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:full_e_commerce_app/utils/dimensions.dart';
import 'package:full_e_commerce_app/widgets/app_column.dart';
import 'package:get/get.dart';

class HomePageFoodSlide extends StatelessWidget {
  const HomePageFoodSlide({
    Key? key,
    required double currentPageValue,
    required double scaleFactor,
    required this.height,
    required this.index,
    required this.popularProduct,
  }) : _currentPageValue = currentPageValue, _scaleFactor = scaleFactor, super(key: key);

  final double _currentPageValue;
  final double _scaleFactor;
  final double height;
  final int index;
  final ProductModel popularProduct;

  @override
  Widget build(BuildContext context) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.85;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){                  
                    Get.toNamed(RouteHelper.getPopularFood(index, "home"));
                  },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: const Color(0xFF69c5df),
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${popularProduct.img!}'),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(
                        color: Colors.white,
                        //blurRadius: 5.0,
                        offset: Offset(-5, 0)),
                    BoxShadow(
                        color: Colors.white,
                        //blurRadius: 5.0,
                        offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15,
                ),
                child: AppColumn(text: popularProduct.name!,)
              ),
            ),
          ), 
        ],
      ),
    );
  }
}

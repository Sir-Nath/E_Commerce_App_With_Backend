import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/pages/food/popular_food_details.dart';
import 'package:full_e_commerce_app/pages/home/widgets/dot_indicator.dart';
import 'package:full_e_commerce_app/pages/home/widgets/home_page_food_list.dart';
import 'package:full_e_commerce_app/pages/home/widgets/home_page_food_slide.dart';
import 'package:full_e_commerce_app/routes/route_helper.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:full_e_commerce_app/utils/dimensions.dart';
import 'package:full_e_commerce_app/widgets/big_text.dart';
import 'package:full_e_commerce_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.85;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProducts) => SizedBox(
            height: 320,
            child: popularProducts.isLoaded
                ? PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return HomePageFoodSlide(
                          currentPageValue: _currentPageValue,
                          scaleFactor: _scaleFactor,
                          height: height,
                          index: position,
                          popularProduct:
                              popularProducts.popularProductList[position]);
                    },
                  )
                : const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                ),
          ),
        ),
        DotIndicator(currentPageValue: _currentPageValue),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
            margin: EdgeInsets.only(
              left: Dimensions.width30,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Recommended'),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    child: BigText(
                      text: '.',
                      color: Colors.black26,
                    )),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: 'Food Pairing'),
                )
              ],
            )),
        const HomePageFoodList()
      ],
    );
  }
}


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:full_e_commerce_app/utils/dimensions.dart';
import 'package:full_e_commerce_app/widgets/app_column.dart';
import 'package:full_e_commerce_app/widgets/app_icon.dart';
import 'package:full_e_commerce_app/widgets/big_text.dart';
import 'package:full_e_commerce_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../cart/cart_page.dart';

// ignore: must_be_immutable
class PopularFoodDetails extends StatelessWidget {
  int pageId;
  PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${product.img!}'),
                ),
              ),
            ),
          ),
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: const AppIcon(
                            icon: Icons.shopping_cart_checkout_outlined),
                      ),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? const Positioned(
                        top: 0,
                            right:0,
                            child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                          )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                      ? Positioned(
                        right: 6,
                        top: 4,
                        child: BigText(
                          text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12,
                          color: Colors.white,
                        ),
                      ):
                          Container()
                    ],
                  );
                })
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: 'Introduce'),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExpandableTextWidget(
                        text: product.description,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            right: Dimensions.width20,
            left: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    right: Dimensions.width20,
                    left: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      popularProduct.setQuantity(false);
                    },
                    child: const Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width5,
                  ),
                  BigText(
                    text: popularProduct.inCartItems.toString(),
                  ),
                  SizedBox(
                    width: Dimensions.width5,
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.setQuantity(true);
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  )
                ]),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                      color: AppColors.mainColor),
                  child: BigText(
                    text: '\$${product.price} | Add to Cart',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

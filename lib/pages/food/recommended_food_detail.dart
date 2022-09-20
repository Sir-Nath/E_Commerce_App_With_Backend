import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/controllers/recommended_products_controller.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:full_e_commerce_app/utils/dimensions.dart';
import 'package:full_e_commerce_app/widgets/app_icon.dart';
import 'package:full_e_commerce_app/widgets/big_text.dart';
import 'package:full_e_commerce_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int listId;
  const RecommendedFoodDetails({
    Key? key,
    required this.listId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var food =
        Get.find<RecommendedProductController>().recommendedProductList[listId];
    Get.find<PopularProductController>()
        .initProduct(food, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios)),
                //const AppIcon(icon: Icons.shopping_cart_checkout_outlined)
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: const AppIcon(
                            icon: Icons.shopping_cart_checkout_outlined),
                      ),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? const Positioned(
                              top: 0,
                              right: 0,
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
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          : Container()
                    ],
                  );
                })
              ],
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.white,
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                      child: BigText(
                    text: food.name,
                    size: Dimensions.font26,
                  )),
                )),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${food.img!}',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: ExpandableTextWidget(
                  text: food.description,
                ),
              )
            ]),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20 * 2.5,
              vertical: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child: AppIcon(
                    icon: Icons.remove,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                BigText(
                  text: '\£${food.price} X ${controller.inCartItems}',
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(true);
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                  ),
                )
              ],
            ),
          ),
          Container(
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
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )),
                GestureDetector(
                  onTap: () {
                    controller.addItem(food);
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
                      text: '£${food.price} Add to Cart',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]);
      }),
    );
  }
}

String test =
    '''According to (World Health Organization, 2020), Malnutrition is characterized by deficiencies, excesses, or imbalances in a person's nutrient- and/or energy-intake. India battles tremendously with malnutrition and even the children are so affected. (De & Chattopadhyay, 2019) stated Children are particularly susceptible to malnutrition because they consume foods with poor nutritional content and because food is distributed inequitably among households. Additionally, due to inadequate care, young children experience frequent infections and a variety of illnesses that can have a deadly or developmentally delayed consequence.
Malnutrition has been for a very long time and many countries have suffered at it hand, it has led to the death of many. (Keusch, 2003) stated that Malnutrition increased a person's susceptibility to infection and that infection worsened nutritional status, starting a vicious cycle of malnutrition-infection that would eventually result in kwashiorkor (whose clinical manifestations were typically also brought on by an infection) and, if left untreated will lead to death. 
Malnutrition has cost India a lot and even affected the world economy. The cost of all types of malnutrition, including undernutrition, micronutrient deficiencies, and over nutrition, has been estimated at US3.5 trillion annually for the world economy. Investment in primary level prevention interventions like health promotion and education makes it interesting to learn from these historical data and studies (Sharma, 2021). While a lot of literature 
dealt with tackling malnutrition in India and even in children as  (Sahu et al., 2015) mentioned that India has a serious public health issue with malnutrition among children under the age of five, not many literatures tackled the problem of malnutrition by recommending effective health policies to help reduced it.
''';

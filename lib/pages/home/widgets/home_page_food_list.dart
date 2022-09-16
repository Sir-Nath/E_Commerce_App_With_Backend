import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/recommended_products_controller.dart';
import 'package:full_e_commerce_app/routes/route_helper.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:full_e_commerce_app/utils/dimensions.dart';
import 'package:full_e_commerce_app/widgets/big_text.dart';
import 'package:full_e_commerce_app/widgets/icon_and_text.dart';
import 'package:full_e_commerce_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class HomePageFoodList extends StatelessWidget {
  const HomePageFoodList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedProductController>(
        builder: (recommendedProduct) => recommendedProduct.isLoaded
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //image Section
                          recommendedProduct.isLoaded ? Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:  NetworkImage('${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${recommendedProduct.recommendedProductList[index].img!}'),
                              ),
                            ),
                          ): const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                          ),
                          //TEXT SECTION
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20)),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                        text: recommendedProduct
                                            .recommendedProductList[index].name),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    SmallText(
                                        text: 'With chinese characteristic'),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        IconAndText(
                                          icon: Icons.circle_sharp,
                                          text: 'Normal',
                                          iconColor: AppColors.iconColor1,
                                        ),
                                        IconAndText(
                                          icon: Icons.location_on,
                                          text: '1.7km',
                                          iconColor: AppColors.mainColor,
                                        ),
                                        IconAndText(
                                          icon: Icons.access_time_rounded,
                                          text: '32min',
                                          iconColor: AppColors.iconColor2,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ));
  }
}

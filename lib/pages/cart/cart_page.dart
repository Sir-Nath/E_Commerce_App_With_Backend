import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: Dimensions.width20,
            top: Dimensions.height20 * 2,
            left: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? const Positioned(
                              top: 0,
                              right: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: Colors.white,
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
                                color: Colors.black,
                              ),
                            )
                          : Container()
                    ],
                  );
                }),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              //color: Colors.red,
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (controller) {
                  return ListView.builder(
                      itemCount: controller.getItems.length,
                      itemBuilder: (_, index) {
                        return SizedBox(
                          height: Dimensions.height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.height20 * 5,
                                height: Dimensions.height20 * 5,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${controller.getItems[index].img!}'))),
                              ),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: controller.getItems[index].name!,
                                        color: Colors.black54,
                                      ),
                                      SmallText(text: 'spicy'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text:
                                                '\$ ${controller.getItems[index].price}',
                                            color: Colors.redAccent,
                                          ),
                                          GetBuilder<PopularProductController>(
                                            builder: (product) {
                                              return Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    right: Dimensions.width10,
                                                    left: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      product.setQuantity(false);
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
                                                      text: controller
                                                          .getItems[index].quantity!
                                                          .toString() //popularProduct.inCartItems.toString(),
                                                      ),
                                                  SizedBox(
                                                    width: Dimensions.width5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      product.setQuantity(true);
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: AppColors.signColor,
                                                    ),
                                                  )
                                                ]),
                                              );
                                            }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

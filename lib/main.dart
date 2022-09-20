import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/controllers/recommended_products_controller.dart';
import 'package:full_e_commerce_app/pages/cart/cart_page.dart';
import 'package:full_e_commerce_app/pages/home/main_food_page.dart';
import 'package:full_e_commerce_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'helper/dependencies.dart' as dep;

void main() async{
  //this will ensure proper binding and that all dependencies are initialized
  WidgetsFlutterBinding.ensureInitialized();
  //this is  method that help initialize certain dependencies
  await dep.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //calling the get list methods before calling GetMaterialApp
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().items;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //home: MainFoodPage()
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes
    );
  }
}

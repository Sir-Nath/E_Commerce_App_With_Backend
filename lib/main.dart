import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/controllers/recommended_products_controller.dart';
import 'package:full_e_commerce_app/pages/home/main_food_page.dart';
import 'package:full_e_commerce_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes
    );
  }
}

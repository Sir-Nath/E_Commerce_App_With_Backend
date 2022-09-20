import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/controllers/recommended_products_controller.dart';
import 'package:full_e_commerce_app/data/api/api_client.dart';
import 'package:full_e_commerce_app/data/repository/popular_product_repo.dart';
import 'package:full_e_commerce_app/data/repository/recommended_products_repo.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../data/repository/cart_repo.dart';

//initializing ApiClient, Repository and controllers

Future<void> init()async{
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepo());

  //Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
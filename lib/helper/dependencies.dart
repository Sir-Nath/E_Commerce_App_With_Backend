import 'package:full_e_commerce_app/controllers/popular_product_controller.dart';
import 'package:full_e_commerce_app/data/api/api_client.dart';
import 'package:full_e_commerce_app/data/repository/popular_product_repo.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init()async{
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //api repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
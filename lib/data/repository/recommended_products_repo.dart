import 'package:full_e_commerce_app/data/api/api_client.dart';
import 'package:full_e_commerce_app/utils/app_constants.dart';
import 'package:get/get.dart';

//this repo creates a function that calls another function from the apiClient class and make it straightforward
class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
//import 'package:full_e_commerce_app/data/api/repository/popular_product_repo.dart';
import 'package:full_e_commerce_app/data/repository/popular_product_repo.dart';
import 'package:full_e_commerce_app/data/repository/recommended_products_repo.dart';
import 'package:get/get.dart';
import 'package:full_e_commerce_app/models/popular_products_model.dart';

class RecommendedProductController extends GetxController {

  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({
    required this.recommendedProductRepo,
  });

  //a list of recommended product from the server
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //this is another method that calls a method in the repo and confirm it status code then convert to a list from json
  Future<void> getRecommendedProductList()async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
    _isLoaded = true;
      update();
    }else{
    }
  }
}


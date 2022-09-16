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

  List<dynamic> _recommendedProductlist = [];
  List<dynamic> get recommendedProductList => _recommendedProductlist;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList()async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      _recommendedProductlist = [];
      _recommendedProductlist.addAll(Product.fromJson(response.body).products);
    _isLoaded = true;
      update();
    }else{

    }
  }
}


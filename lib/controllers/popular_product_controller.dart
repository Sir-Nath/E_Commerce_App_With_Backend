import 'package:full_e_commerce_app/data/api/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:full_e_commerce_app/models/popular_products_model.dart';


class PopularProductController extends GetxController {

  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });

  List<dynamic> _popularProductlist = [];
  List<dynamic> get popularProductList => _popularProductlist;

  Future<void> getPopularProductList()async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductlist = [];
      _popularProductlist.addAll(Product.fromJson(response.body).products);

      update();
    }else{

    }
  }
}


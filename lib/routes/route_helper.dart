import 'dart:developer';

import 'package:full_e_commerce_app/pages/food/popular_food_details.dart';
import 'package:full_e_commerce_app/pages/food/recommended_food_detail.dart';
import 'package:full_e_commerce_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initial = '/';
  static const String popularFood = '/popular-food';
   static const String recommendedFood = '/recommended-food';

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getInitial() => initial;
  static String getRecommendedFood(int listId) => '$recommendedFood?listId=$listId';


  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=> const MainFoodPage()),
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetails(pageId: int.parse(pageId!));
    },
    ),
    GetPage(name: recommendedFood, page: (){
      var listId = Get.parameters['listId'];
      return RecommendedFoodDetails(listId: int.parse(listId!));
    } ,
    transition: Transition.fadeIn
    )
  ];
}
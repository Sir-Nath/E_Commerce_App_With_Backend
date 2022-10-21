import 'package:full_e_commerce_app/pages/food/popular_food_details.dart';
import 'package:full_e_commerce_app/pages/food/recommended_food_detail.dart';
import 'package:full_e_commerce_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/home/homePage.dart';

class RouteHelper {
  //defining routes name
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';

  //writing a method that will return the route name and can accept parameters when called
  static String getPopularFood(int pageId, String page) {
    //another way of passing arguments across route in GetX
    return '$popularFood?pageId=$pageId&page=$page';
  }

  static String getInitial() => initial;
  static String getCartPage() => cartPage;
  static String getRecommendedFood(int listId, String page) =>
      '$recommendedFood?listId=$listId&page=$page';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
      name: popularFood,
      page: () {
        //accepting the parameter and using it in the page that was called
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
      },
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var listId = Get.parameters['listId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(listId: int.parse(listId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn)
  ];
}

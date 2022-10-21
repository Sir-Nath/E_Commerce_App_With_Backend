import 'dart:developer';
import 'package:full_e_commerce_app/data/repository/popular_product_repo.dart';
import 'package:full_e_commerce_app/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:full_e_commerce_app/models/popular_products_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });

  //a list of popular product fetch from the server
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  //an instance of thr cart controller
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //this is the quantity of each product selected before adding to cart
  int _quantity = 0;
  int get quantity => _quantity;

  //this is the amount of a product available in cart already
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  //this method retrieves our list from the server and saves it ready for use
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  //this is where we either add or remove a product before adding to cart
  void setQuantity(bool isIncrement) {
    if(isIncrement){
      //on increasing, we check the quantity of the increase
      _quantity = checkQuantity( _quantity + 1);
    }else{
      _quantity = checkQuantity(_quantity - 1);
    }
    //we use update if our method is a void
    update();
  }

  //this method is to check the quantity of a product before adding to cart
  //it takes a parameter quantity
  int checkQuantity(int quantity){
    //if the addition of what is in cart and is selected sum up to being less then zero then we display an error to user
    if((_inCartItems + quantity) < 0){
      Get.snackbar('Invalid Cart item', 'You can\'t have less than 0 count');
      //if in cart item is greater than zero
      if(_inCartItems > 0){
        //we update quantity with in cart value
        _quantity = -_inCartItems;
        //and return it
        return _quantity;
      }
      //if in cart is less than zero we return zero
      return 0;
      //if in cart item plus quantity is more than zero
    }else if((_inCartItems + quantity) > 20){
      //we send a snack bar
      Get.snackbar('Invalid Cart item', 'You can\'t have more than 20 count');
      //amd return 20
      return 20;
      //if it is neither less than 0 or greater than 20, we return the quantity we receive
    }else{
      return quantity;
    }
  }


  void initProduct(ProductModel product, CartController cart){
    //we set quantity and in cart Items to zero
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    // we instantiate exist to false
    var exist = false;
    //we the use a method from cart controller to check if a product exist in the cart
    exist =  _cart.existInCart(product);
    if(exist){
      //if it exist we set in cart items to the number of quantity saved in the map.
      _inCartItems = _cart.getQuantity(product);
    }
  }

  //we use this to add product into a map
  void addItem(ProductModel product){
      //we call the add item from cart controller to add a product and quantity
      _cart.addItem(product, _quantity);
      //we then reset quantity to zero
      _quantity = 0;
      //we the get the quantity of product in cart and update it to in cart item
      _inCartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        log('The iD is ${value.id} the quantity is ${value.quantity}');
      });
      update();
  }

  //this method is from cart controller
  int get totalItems{
    return _cart.totalItems;
  }

  //this method is from cart controller
  List<CartModel> get getItems {
    return _cart.getItems;
  }

}


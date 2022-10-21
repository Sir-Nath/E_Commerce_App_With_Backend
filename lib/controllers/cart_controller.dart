import 'dart:developer';

import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../models/popular_products_model.dart';
import '../data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo,
  });

  //will be storing the cart detail in this map.
  Map<int, CartModel> _items = {};
  //this is to access the data in the private _items from other classes/files
  Map<int, CartModel> get items => _items;


  //our add item function takes a product and quantity variable
  void addItem(ProductModel product, int quantity) {
    //on calling the add item function, i reset the total quantity to zero
    var totalQuantity = 0;
    //we are checking if an instance of the product we accepted is in the _items map
    if (_items.containsKey(product.id)) {
      //if it is, we want to update the quantity variable in it with the new variable we are accepting and the product id as the key
      _items.update(product.id!, (value) {
        //we will then access the previous quantity saved and add the new quantity we receive to make it a new variable total quantity
        totalQuantity = value.quantity! + quantity;
        //after all this logic, we will be returning an instance of CartModel modified
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: totalQuantity,  //value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product
        );
      });
      //we check if the new quantity called total variable is equal or less than zero
      if(totalQuantity <= 0){
        //if it is we remove the cart product using the id as key
        _items.remove(product.id);
      }
      //if the Product received is not in our Map,
    } else {
      //we check that the quantity is above 0
     if(quantity > 0){
       //we then put in the product in the map with the id as the key and the value as a cart model derived from the product model receive
       _items.putIfAbsent(
         product.id!,
             () {
           return CartModel(
             id: product.id,
             name: product.name,
             price: product.price,
             img: product.img,
             quantity: quantity,
             isExist: true,
             time: DateTime.now().toString(),
             product: product
           );
         },
       );
       //if the quantity is equal ot less than 0, we send user a feedback
     }else{
       Get.snackbar('Invalid Cart item', 'Add at least an item');
     }
    }
    update();
  }

  //this is a method to check if our product exist in the cart and returns a bool of true and false
  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else{
      return false;
    }
  }

  //this method is to get the quantity of a product in the cart map
  int getQuantity(ProductModel product){
    //we set quantity to zero first
    var quantity = 0;
    //we check if our product is in the cart
    if(_items.containsKey(product.id)){
      //if it is, we perform an action on each value of the map
      _items.forEach((key, value) {
        //we compare the key with the product id and if it is the same, we set the quantity from the product into the local variable created
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    //if our product is not in the map then we return quantity as zero
    return quantity;
  }

  //this is a function to get the total items in the cart
  int get totalItems{
    // we set total quantity to zero to start with
    var totalQuantity = 0;
    //we check through the value(cart model) in the map
    _items.forEach((key, value) {
      //and add up the quantity of each cart product all through
      totalQuantity += value.quantity!;
    });
    //we then return the new value of totalQuantity
    return totalQuantity;
  }


  //this is a getter to get the values in the map as a list
  List<CartModel> get getItems{
    //we map through and then access the values
    return _items.entries.map((e){
      return e.value;
      //and turn it into a list
    }).toList();
  }
int get totalAmount{
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
}

}

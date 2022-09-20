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
        );
      });
      //we check if the new quantity called total variable is equal or less than zero
      if(totalQuantity <= 0){
        //if it is we remove the cart product using the ig as key
        _items.remove(product.id);
      }
    } else {
     if(quantity > 0){
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
           );
         },
       );
     }else{
       Get.snackbar('Invalid Cart item', 'Add at least an item');
     }
    }
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else{
      return false;
    }
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }


  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }


}

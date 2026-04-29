// {
// 'id ': '123'
// "product" : {      }
// "user" : "123"
// "quantity" : 1
// 'color' : null
// 'size' : null
//  }
import 'package:crafty_bay/features/product/data/models/product_model.dart';

class CartModel {
  final String id;
  final ProductModel productModel;
  // changeable kore rakhlam ei variable take
  int quantity;
  final String? color;
  final String? size;

  CartModel({
    required this.id,
    required this.productModel,
    required this.quantity,
    required this.color,
    required this.size,
  });

  // convert from api information to object
  // convert from json to object
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      productModel: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
    );
  }
}
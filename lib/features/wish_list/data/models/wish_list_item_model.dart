


import '../../../product/data/models/product_model.dart';

class WishListItemModel {
  final String id;
  final ProductModel product;

  WishListItemModel({
    required this.id,
    required this.product
  });

  factory WishListItemModel.fromJson(Map<String, dynamic> json) {
    return WishListItemModel(
      id: json['_id'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
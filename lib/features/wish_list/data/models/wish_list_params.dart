

class WishListParams {
  final String productId;

  WishListParams({
    required this.productId
  });
// convert from object to json
// to send data to api
  Map<String, dynamic> toJson() {
    return {
      "product": productId,
    };
  }
}
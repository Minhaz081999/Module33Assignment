import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls/urls.dart';
import '../../../../core/network_caller/network_response.dart';
import '../../data/models/cart_model.dart';

class CartListProvider extends ChangeNotifier {
  //------------ ui variables -----------------
  bool _getCartListInProgress = false;

  bool get getCartListInProgress => _getCartListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

// --------- GET CART ITEM ----------------------------
  Future<bool> getCartList() async {
    // 1) Starting from here ---------------------
    // this is for return type variable
    bool isSuccess = false;
    // if true then see Circle Progress Indicator
    _getCartListInProgress = true;
    notifyListeners();
    // ... API GET Call   ...
    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.cartListUrl,
    );
// ডাটা সফলভাবে আসলে এখানে ঢুকবে
    if (response.isSuccess) {
      List<CartModel> carts = [];
      for (Map<String, dynamic> cart in response.body!['data']['results']) {
        carts.add(CartModel.fromJson(cart));
      }
      _cartList = carts;
      _errorMessage = null;
      isSuccess = true;
    }
    // এরর মেসেজ সেভ করো
    else {
      _errorMessage = response.errorMessage;
    }
// 2) Ending from here------------------------
    // if false then not to see Circle Progress Indicator
    _getCartListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
// ------------------- Delete Method -------------------
  Future<bool> deleteCartItem(String cartItemId) async {
    bool isSuccess = false;
    _getCartListInProgress = true;
    notifyListeners();

    // URL তৈরি করা (আপনার URL ক্লাস অনুযায়ী)
    final String url = Urls.deleteCartItemUrl(cartItemId);

    // NetworkCaller দিয়ে DELETE রিকুয়েস্ট পাঠানো
    final NetworkResponse response = await getNetworkCaller().deleteRequest(url);

    if (response.isSuccess) {
      // এপিআই থেকে ডিলিট সফল হলে লোকাল লিস্ট থেকেও রিমুভ করে দাও
      _cartList.removeWhere((item) => item.id == cartItemId);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCartListInProgress = false;
    notifyListeners();
    return isSuccess;
  }

  int get totalQuantity => _cartList.length;

  double get totalPrice {
    double total = 0;
    for (CartModel cart in _cartList) {
      total += cart.productModel.currentPrice * cart.quantity;
    }
    return total;
  }

  void updateCartItemQuantity(String cartId, int quantity) {
    _cartList.firstWhere((cartItem) => cartItem.id == cartId).quantity =
        quantity;
    notifyListeners();
  }
}
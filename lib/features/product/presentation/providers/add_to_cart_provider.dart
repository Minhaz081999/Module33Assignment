import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls/urls.dart';
import '../../../../core/network_caller/network_response.dart';
import '../../data/models/add_to_cart_params.dart';

class AddToCartProvider extends ChangeNotifier {
  //----------------- UI variables -------------------
  // _addToCartInProgress: স্ক্রিনে লোডার দেখাবে কি না তা ঠিক করবে।
  bool _addToCartInProgress = false;

  bool get addToCartInProgress => _addToCartInProgress;

  // errorMessage: যদি কিছু ভুল হয়, তবে লাল কালিতে মেসেজ দেখাবে।
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // -----------------------------------------------------------------------------
  Future<bool> addToCart(AddToCartParams params) async {
    // 1) Starting from here ---------------------
    // this is for return type variable
    bool isSuccess = false;
    // if true then see Circle Progress Indicator
    _addToCartInProgress = true;
    notifyListeners();

    // ... API Call (POST Request) ...
    // AddToCart-এর সিম্পল ফ্লো :
    // 'Add to Cart' এ ক্লিক করে -> addToCart(params) কল হয় -> Loading শুরু হয় ->
    // সার্ভারে ডাটা পাঠানো হয় (POST) -> সার্ভার থেকে কনফার্মেশন আসে -> Loading বন্ধ হয় ->
    // UI-তে সাকসেস বা এরর মেসেজ দেখায়।
    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.addToCartUrl,
      body: params.toJson(),
    );
    // ডাটা সফলভাবে আসলে এখানে ঢুকবে
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    }
    // এরর মেসেজ সেভ করো
    else {
      _errorMessage = response.errorMessage;
    }
    // 2) Ending from here------------------------
    // if false then not to see Circle Progress Indicator
    _addToCartInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}

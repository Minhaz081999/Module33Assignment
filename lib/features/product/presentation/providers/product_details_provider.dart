import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app/setup_network_client.dart';
import '../../../../app/urls/urls.dart';
import '../../../../core/network_caller/network_response.dart';
import '../../data/models/product_details_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  //----------------- UI variables -------------------
  // getProductDetailsInProgress: স্ক্রিনে লোডার দেখাবে কি না তা ঠিক করবে।
  bool _getProductDetailsInProgress = false;

  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  // errorMessage: যদি কিছু ভুল হয়, তবে লাল কালিতে মেসেজ দেখাবে।
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // productDetails: এটি আপনার মডেল ক্লাস যা স্ক্রিনে ছবি, দাম এবং নাম দেখাবে।
  ProductDetailsModel? _productDetails;

  ProductDetailsModel? get productDetails => _productDetails;
// ----------------------------------------------------------------------------
  Future<bool> getProductDetails(String productId) async {
    // 1) Starting from here ---------------------
    // this is for return type variable
    bool isSuccess = false;

    // if true then see Circle Progress Indicator
    _getProductDetailsInProgress = true; // কাজ শুরু (Loader দেখাও)
    notifyListeners();

    // ... API Call ...
    // সিম্পল ফ্লো:
    // User click করে -> getProductDetails কল হয় ->
    // Loading শুরু হয় -> API থেকে ডাটা আসে -> Loading বন্ধ হয় -> UI আপডেট হয়।
    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getProductDetailsUrl(productId),
    );
    // ডাটা সফলভাবে আসলে এখানে ঢুকবে
    if (response.isSuccess) {
      _productDetails = ProductDetailsModel.fromJson(response.body!['data']);
      _errorMessage = null;
      isSuccess = true;
    }
    // এরর মেসেজ সেভ করো
    else {
      _errorMessage = response.errorMessage;
    }

    // 2) Ending from here------------------------
    // if false then not to see Circle Progress Indicator
    _getProductDetailsInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}

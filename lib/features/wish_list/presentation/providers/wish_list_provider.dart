import 'dart:convert';

import 'package:crafty_bay/features/wish_list/data/models/wish_list_params.dart';
import 'package:flutter/material.dart';
import '../../../../app/setup_network_client.dart';
import '../../../../app/urls/urls.dart';
import '../../../../core/network_caller/network_response.dart';
import '../../data/models/wish_list_item_model.dart';

class WishListProvider extends ChangeNotifier {
  final int _pageSize = 30;
  int _currentPage = 0;
  int? _lastPage;

  bool _getInitialDataInProgress = false;
  bool _getMoreDataInProgress = false;

  bool get getInitialDataInProgress => _getInitialDataInProgress;

  bool get getMoreDataInProgress => _getMoreDataInProgress;

  bool _addToWishListInProgress = false;

  bool get addToWishListInProgress => _addToWishListInProgress;
  List<WishListItemModel> _wishListItems = [];

  List<WishListItemModel> get wishListItems => _wishListItems;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<String> loadingProductIds = [];

  // UI call this function()
  bool isFavorite(String productId) {
    return loadingProductIds.contains(productId);
  }

  // ------------------ Add to Wishlist ------------------
  Future<bool> addToWishList(WishListParams params) async {
    bool isSuccess = false;
    _addToWishListInProgress = true;

    notifyListeners();
    // store PRODUCT ID in a list(Bag)
    loadingProductIds.add(params.productId);
    // final Map<String, dynamic> requestBody = {
    //   "product": productId,
    // };

    // Note: Urls.addToWishListUrl needs to be added in Urls class
    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.addToWishListUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ??
          'Something went wrong while adding to wishlist';
      ;
    }

    // কাজ শেষ হলে লিস্ট থেকে আইডি রিমুভ করুন
    loadingProductIds.remove(params.productId);
    _addToWishListInProgress = false;
    notifyListeners();
    return isSuccess;
  }

  // --------- Get Wish List ------------------
  // ------------------ Get Wishlist Items (Pagination) ------------------
  Future<bool> getWishListItems() async {
    if (_lastPage != null && _currentPage >= _lastPage!) {
      return false;
    }

    _currentPage++;
    bool isSuccess = false;

    if (isInitialLoading) {
      _getInitialDataInProgress = true;
      _wishListItems.clear();
    } else {
      _getMoreDataInProgress = true;
    }
    notifyListeners();

    if (_currentPage == 1) {
      _getInitialDataInProgress = true;
      _wishListItems.clear(); // নতুন করে লোড করার জন্য ক্লিয়ার করা
    } else {
      _getMoreDataInProgress = true;
    }
    notifyListeners();
    // store PRODUCT ID in a list(Bag)

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getWishListUrl(_pageSize, _currentPage),
    );

    if (response.isSuccess) {
      _lastPage = response.body!['data']['last_page'];
      final List<dynamic> data = response.body!['data']['results'];
      for (var item in data) {
        _wishListItems.add(WishListItemModel.fromJson(item));
      }
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getInitialDataInProgress = false;
    _getMoreDataInProgress = false;
    notifyListeners();
    return isSuccess;
  }
  bool get isInitialLoading => _currentPage == 1;
  bool get isLoading => _getInitialDataInProgress || _getMoreDataInProgress;
}

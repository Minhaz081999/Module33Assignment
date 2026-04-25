import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls/urls.dart';
import '../../../../core/network_caller/network_response.dart';


class productListProvider extends ChangeNotifier {
  final int _pageCount = 30;
  int _currentPage = 0;
  int? _lastPage;

  // Initial Loading
  bool _getInitialDataInProgress = false;

  // More data loading
  bool _getMoreDataInProgress = false;

  List<ProductModel> _productList = [];

  bool get getInitialDataInProgress => _getInitialDataInProgress;

  bool get getMoreDataInProgress => _getMoreDataInProgress;

  List<ProductModel> get productList => _productList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProducts(String categoryId) async {
    if (_lastPage != null && _currentPage >= _lastPage!) {
      return false;
    }
    bool isSuccess = false;

    _currentPage++;

    if (isInitialLoading) {
      _getInitialDataInProgress = true;
    } else {
      _getMoreDataInProgress = true;
    }
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getProductsUrl(_pageCount, _currentPage),
    );

    if (response.isSuccess) {
      List<ProductModel> products = [];
      _lastPage = response.body!['data']['last_page'];
      for (Map<String, dynamic> product in response.body!['data']['results']) {
        products.add(ProductModel.fromJson(product) );
      }
      _productList.addAll(products);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (isInitialLoading) {
      _getInitialDataInProgress = false;
    } else {
      _getMoreDataInProgress = false;
    }
    notifyListeners();

    return isSuccess;
  }

  bool get isInitialLoading => _currentPage == 1;

  bool get isLoading => _getInitialDataInProgress || _getMoreDataInProgress;
}
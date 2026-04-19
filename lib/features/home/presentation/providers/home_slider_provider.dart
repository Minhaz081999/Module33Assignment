import 'package:crafty_bay/app/setup_network_client.dart';
import 'package:crafty_bay/app/urls/urls.dart';
import 'package:crafty_bay/core/network_caller/network_response.dart';
import 'package:crafty_bay/features/home/data/models/home_slider_model.dart';
import 'package:flutter/cupertino.dart';

class HomeSliderProvider extends ChangeNotifier {
  // for Circle Progress indicator
  bool _getHomeSliderInProgress = false;

  bool get getHomeSliderInProgress => _getHomeSliderInProgress;

  // API theke error message show korar jonno
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<HomeSliderModel> _homeSliders = [];

  List<HomeSliderModel> get homeSliders => _homeSliders;

  Future<bool> getHomeSlider() async {
    // 1) Starting from here ---------------------
    // this is for return type variable
    bool isSuccess = false;
    // if true then see Circle Progress Indicator
    _getHomeSliderInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.homeSlidersUrl,
    );

    if (response.isSuccess) {
      // সহজ কথায়, for-in লুপ মানে হলো:
      // একটা বড় ঝুড়ির (List) ভেতর থেকে একেকটা জিনিস বের করে নিয়ে আসা।
      List<HomeSliderModel> sliders = [];
      for (Map<String, dynamic> slider in response.body!['data']['results'] ) {
        sliders.add(HomeSliderModel.fromJson(slider));
      }
      _homeSliders = sliders ;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    // 2) Ending from here------------------------
    // if false then not to see Circle Progress Indicator
    _getHomeSliderInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}

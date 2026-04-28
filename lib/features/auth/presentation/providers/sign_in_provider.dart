import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:crafty_bay/app/setup_network_client.dart';
import 'package:crafty_bay/app/urls/urls.dart';
import 'package:crafty_bay/core/network_caller/network_response.dart';
import 'package:crafty_bay/features/auth/data/models/sign_in_params.dart';

import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/shared/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

class SignInProvider extends ChangeNotifier {
  //------ for CircularProgressIndicator --------
  bool _signInProgress = false;

  bool get signInProgress => _signInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // use this function() only into 'SignUp Button' as True or False
  Future<bool> signInIsSuccess(SignInParams params) async {
    // eta hoche return Type er value
    bool isSuccess = false;

    // যদি true হয়, তবে স্ক্রিনে CircularProgressIndicator ঘুরবে।
    _signInProgress = true;
    notifyListeners();
    // ----- Operation Start --------
    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.signInUrl,
      body: params.toJson(),
      fromLogin: true
    );

    if (response.isSuccess) {
      //------ Save User information into Local Database ---------------
      String accessToken = response.body!['data']['token'];
      UserModel userModel = UserModel.fromJson(response.body!['data']['user']);
      await AuthController.saveUserData(accessToken, userModel);
      // ----------X--------------
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _signInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}

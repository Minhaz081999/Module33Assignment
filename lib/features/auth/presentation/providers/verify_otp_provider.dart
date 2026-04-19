import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:crafty_bay/app/setup_network_client.dart';
import 'package:crafty_bay/app/urls/urls.dart';
import 'package:crafty_bay/core/network_caller/network_response.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/shared/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

class VerifyOtpProvider extends ChangeNotifier {
  //------ for CircularProgressIndicator --------
  bool _verifyOtpInProgress = false;

  bool get verifyOtpInProgress => _verifyOtpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // use this function() only into 'SignUp Button' as True or False
  Future<bool> verifyOtpIsSuccess(VerifyOtpParams params) async {
    // eta hoche return Type er value
    bool isSuccess = false;

    // যদি true হয়, তবে স্ক্রিনে CircularProgressIndicator ঘুরবে।
    _verifyOtpInProgress = true;
    notifyListeners();
    // ----- Operation Start --------
    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.verifyOtpUrl,
      body: params.toJson(),
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

    _verifyOtpInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}

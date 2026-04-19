import 'package:crafty_bay/app/setup_network_client.dart';
import 'package:crafty_bay/app/urls/urls.dart';
import 'package:crafty_bay/core/network_caller/network_response.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:flutter/foundation.dart';

class SignUpProvider extends ChangeNotifier{
  //------ for CircularProgressIndicator --------
  bool _signUpInProgress = false ;

  bool get signUpInProgress => _signUpInProgress;

  String ? _errorMessage;

  String? get errorMessage => _errorMessage;

  // use this function() only into 'SignUp Button' as True or False
  Future<bool> signUpIsSuccess( SignUpParams params )async{
    // eta hoche return Type er value
    bool isSuccess = false;

    // যদি true হয়, তবে স্ক্রিনে CircularProgressIndicator ঘুরবে।
    _signUpInProgress = true;
    notifyListeners();
    // ----- Operation Start --------
    final NetworkResponse response = await getNetworkCaller().postRequest(
        Urls.signUpUrl,
        body: params.toJson()
    );

    if( response.isSuccess ){

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _signUpInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}
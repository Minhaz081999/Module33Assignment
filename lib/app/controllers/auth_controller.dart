import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/shared/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'userData';
// ei duita variable ke globally use kora hobe --------------------------------
  static String? accessToken;
  static UserModel? userModel;

  // save user data into Local Database -----------------------
  //*** It is used in verifyOTP SCREEN and Login Screen ***
  static Future<void> saveUserData(String token, UserModel user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_accessTokenKey, token);
    await preferences.setString(_userDataKey, jsonEncode(user.tojson()));

    accessToken = token;
    userModel = user;
  }

  // get user data from Local Database --------------------
  // *** it is used in Splash SCREEN ***
  static Future<void> loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   accessToken = preferences.getString(_accessTokenKey);
   if(accessToken == null){
     // get out from Future<void> loadUserData()
     return;
   }
   userModel = UserModel.fromJson(jsonDecode(preferences.getString(_userDataKey)!));
  }
  // User logged in or not => True or False -------------------------
static Future<bool> isLoggedIn()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(_accessTokenKey);
    if(token != null  ){
    return true;
    }else{
      return false;
    }
}
// Clear User Data when log out
static Future<void> clearUserData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(_accessTokenKey);
    preferences.remove(_userDataKey);
    accessToken = null ;
    userModel = null ;

}


// -----------------------X ------------------------------
}

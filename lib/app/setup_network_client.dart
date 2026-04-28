import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:crafty_bay/app/crafty_bay_app.dart';
import 'package:crafty_bay/core/network_caller/network_caller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
// This function is used for OBJECT creation
// Example :
// 1) NetworkCaller object = NetworkCaller(
//                                          headers: ()=>{},
//                                          onUnauthorize: ()=>{
//                                            // Logout from app
//                                            // Clear user data
//                                            // Redirect to the sign in UI
//                                                              }
//                                         );
// 2) getNetworkCaller. variable/function()
// USE CASE :
// getNetworkCaller.getRequest(URL)
// getNetworkCaller.postRequest(URL,Map<>)
// getNetworkCaller.patchRequest(URL,Map<>)
// getNetworkCaller.putRequest(URL,Map<>)
// getNetworkCaller.deleteRequest(URL,Map<>)
//  headers: ()=>{
//       'Content-Type': 'application/json'
//     }, mane Application er json data niye jacche
NetworkCaller getNetworkCaller (){
  return NetworkCaller(
    headers: () {
      final headers = {'Content-Type': 'application/json'};
      // this is happened during Login button click otherwise not
      if(AuthController.accessToken != null ){
        headers['token'] = '${AuthController.accessToken}' ;
      }
      return headers;
    },
    onUnauthorize: ()=>{
      // Logout from app, // Clear user data
      AuthController.clearUserData(),
      // if unAuthorize then move to 'SignIn page '
      // Redirect to the sign in UI
      CraftyBayApp.navigatorkey.currentState!.pushNamed(SignInScreen.name)


    }
  );
}

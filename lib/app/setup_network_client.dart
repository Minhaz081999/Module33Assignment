import 'package:crafty_bay/core/network_caller/network_caller.dart';
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
    headers: ()=>{
      'Content-Type': 'application/json'
    },
    onUnauthorize: ()=>{
      // Logout from app
      // Clear user data
      // Redirect to the sign in UI
    }
  );
}

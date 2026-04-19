class Urls {

  static const String _baseURL = 'https://ecom-rs8e.onrender.com/api';
  static const String signUpUrl = '${_baseURL}/auth/signup';
  static const String verifyOtpUrl = '${_baseURL}/auth/verify-otp';
  static const String signInUrl = '${_baseURL}/auth/login';

  static const String homeSlidersUrl = '${_baseURL}/slides';
  static String getCategoriesUrl(int pageSize, int pageNo) =>
      '$_baseURL/categories?page=$pageNo&count=$pageSize';


}
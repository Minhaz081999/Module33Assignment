import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'network_response.dart';

class NetworkCaller {

  NetworkCaller({required this.headers, required this.onUnauthorize});

  final Map<String, String> Function() headers;


  final VoidCallback onUnauthorize;


  // --------- Printer ------------------
  final Logger _logger = Logger();

  void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i('URL=>$url\n Body =>$body');
  }

  void _logResponse(Response response) {
    _logger.i('''
       URL => ${response.request?.url}
       STATUS CODE => ${response.statusCode}
       BODY => ${response.body}
    ''');
  }

  // ---------------- GET Request -----------------------
  Future<NetworkResponse> getRequest(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      _logRequest(url);
      // print(uri);
      // call GET request & take response
      Response response = await get(uri, headers: headers());
      _logResponse(response);
      //print(response);
      // Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        // store INFORMATION into Model(NetworkResponse)
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      }else if (response.statusCode == 400) {
        // Unauthorize
        onUnauthorize();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorize',
        );
      }
      // Failed
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: decodedJson['message'],
        );
      }
    } on Exception catch (e) {
      // TODO
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ---------------- POST Request -----------------------
  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  })async {
    try {
      final Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      // print(uri);
      // call POST request & take response
      Response response = await post(
        uri,
        headers: headers(),
        body: jsonEncode(body),
      );

      _logResponse(response);
      //print(response);
      // for Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        // store INFORMATION into Model(NetworkResponse)
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // for Unauthorize
        onUnauthorize();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorize',
        );
      }
      // Failed
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: decodedJson['message'],
        );
      }
    } on Exception catch (e) {
      // TODO
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // -------------------- PUT Request -----------------
  Future<NetworkResponse> putRequest(
      String url, {
        Map<String, dynamic>? body,
      })
  async {
    try {
      final Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      // print(uri);
      // call POST request & take response
      Response response = await put(
        uri,
        headers: headers(),
        body: jsonEncode(body),
      );

      _logResponse(response);
      //print(response);
      // Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        // store INFORMATION into Model(NetworkResponse)
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      } else if (response.statusCode == 400) {
        // Unauthorize
        onUnauthorize();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorize',
        );
      }
      // Failed
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: decodedJson['message'],
        );
      }
    } on Exception catch (e) {
      // TODO
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ------------------- PATCH Request --------------------
  // for partial update
  Future<NetworkResponse> patchRequest(
      String url, {
        Map<String, dynamic>? body,
      })
  async {
    try {
      final Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      // print(uri);
      // call POST request & take response
      Response response = await patch(
        uri,
        headers: headers(),
        body: jsonEncode(body),
      );

      _logResponse(response);
      //print(response);
      // Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        // store INFORMATION into Model(NetworkResponse)
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      } else if (response.statusCode == 400) {
        // Unauthorize
        onUnauthorize();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorize',
        );
      }
      // Failed
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: decodedJson['message'],
        );
      }
    } on Exception catch (e) {
      // TODO
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ----------------- DELETE Request -------------------
  Future<NetworkResponse> deleteRequest(
    String url, {
    Map<String, dynamic>? body,
  })
  async {
    try {
      final Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      // print(uri);
      // call POST request & take response
      Response response = await delete(
        uri,
        headers: headers(),
        body: jsonEncode(body),
      );

      _logResponse(response);
      //print(response);
      // Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        // store INFORMATION into Model(NetworkResponse)
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      } else if (response.statusCode == 400) {
        // Unauthorize
        onUnauthorize();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Unauthorize',
        );
      }
      // Failed
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: decodedJson['message'],
        );
      }
    } on Exception catch (e) {
      // TODO
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}



import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';

class LoginApiCall extends BaseApiService {
  Future callApi({required phone, required password}) async {
    try {
      var response = await getDio()!.post(
        loginPath,
        queryParameters: {"phone": phone, "password": password},
      );
      // loginResponse = Login.fromJson(response.data);
      // return loginResponse;
    } on DioException catch (e) {
      if (kDebugMode) {
        log(e.type.toString());
        log(e.response.toString());
      }
      // return Login(
      //     message: e.response!.data != null
      //         ? e.response!.data['message']
      //         : handleError(e));
    }
  }
}

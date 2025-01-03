import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/models/login_response/login_response.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/widgets/progressBar.dart';
import 'package:readers_circle/widgets/snackbar.dart';

class AuthProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  Status get status => _status;
  Status _status = Status.none;
  late LoginResponse _loginResponse;

  LoginResponse get loginResponse => _loginResponse;

  set loginResponse(LoginResponse value) {
    _loginResponse = value;
  }

  Future<int> loginCall({
    required String email,
    required String password,
  }) async {
    try {
      final response = await getDio()!
          .post(loginPath, data: {'email': email, 'password': password});

      _loginResponse = LoginResponse.fromJson(response.data);
      CustomSnackBar(text: _loginResponse.message!, isError: true);
      _status = Status.success;
      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      final responseJson = json.decode(e.response.toString());
      CustomSnackBar(text: responseJson["message"], isError: true);
      _status = Status.failed;
      notifyListeners();
      return e.response!.statusCode!;
    } finally {
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<bool> checkIfLoggedin() async {
    bool isLoggedIn = await sharedPref.readBool("isLoggedIn") ?? false;
    return isLoggedIn;
  }
}

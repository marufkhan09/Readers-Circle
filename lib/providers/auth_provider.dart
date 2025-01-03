import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/models/login_response/login_response.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';

class AuthProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  Status get status => _status;
  Status _status = Status.none;
  late LoginResponse _loginResponse;

  LoginResponse get loginResponse => _loginResponse;

  set loginResponse(LoginResponse value) {
    _loginResponse = value;
  }

//login
  Future<int> loginCall(
      {required String email, required String password}) async {
    try {
      final response = await getDio()!
          .post(loginPath, data: {'email': email, 'password': password});
      _loginResponse = LoginResponse.fromJson(response.data);
      sharedPref.saveBool("isLoggedIn", true);
      showMessageToast(message: _loginResponse.message!);
      _status = Status.success;
      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      final responseJson = json.decode(e.response.toString());
      showMessageToast(message: responseJson["message"]);
      _status = Status.failed;
      notifyListeners();
      return e.response!.statusCode!;
    } finally {
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  //registration

  Future<int> registerCall({
    required String fName,
    required String lName,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await getDio()!.post(registerPath, data: {
        'first_name': fName,
        'last_name': lName,
        'email': email,
        'phone_number': phone,
        'account_type': "both"
      });

      final responseJson = json.decode(response.toString());
      showMessageToast(message: responseJson["message"]);
      _status = Status.success;
      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      final responseJson = json.decode(e.response.toString());
      showMessageToast(message: responseJson["message"]);
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

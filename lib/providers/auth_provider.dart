import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/models/login_response/login_response.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';
import 'package:readers_circle/widgets/progressBar.dart';

class AuthProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  late LoginResponse _loginResponse;

  LoginResponse get loginResponse => _loginResponse;

  set loginResponse(LoginResponse value) {
    _loginResponse = value;
  }

//login
  Future<int> loginCall({
    required String email,
    required String password,
  }) async {
    CustomProgressDialog.show(message: "Signing In...", isDismissible: false);
    try {
      // Make the API call
      final response = await getDio()!
          .post(loginPath, data: {'email': email, 'password': password});

      // Parse the response into the LoginResponse model
      _loginResponse = LoginResponse.fromJson(response.data);

      // Save login status and response data to SharedPreferences
      sharedPref.saveBool("isLoggedIn", true);
      sharedPref.saveString(
          "loginResponse", json.encode(_loginResponse.toJson()));
      // Show a success toast message
      showMessageToast(message: _loginResponse.message!);

      // Update the status and notify listeners

      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      // Handle errors
      final responseJson = json.decode(e.response.toString());
      showMessageToast(message: responseJson["message"]);

      notifyListeners();
      return e.response!.statusCode!;
    } finally {
      // Always notify listeners at the end
      CustomProgressDialog.hide();
      notifyListeners();
    }
  }

  //registration

  Future<int> registerCall({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String pass,
    required String cPass,
    required String type,
  }) async {
    CustomProgressDialog.show(message: "Loading...", isDismissible: false);
    try {
      final response = await getDio()!.post(registerPath, data: {
        'first_name': fName,
        'last_name': lName,
        'email': email,
        'phone_number': phone,
        'account_type': type,
        'password': pass,
        'confirm_password': cPass
      });

      final responseJson = json.decode(response.toString());
      showMessageToast(message: responseJson["message"]);

      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      final responseJson = json.decode(e.response.toString());
      showMessageToast(message: responseJson["message"]);

      notifyListeners();
      return e.response!.statusCode!;
    } finally {
      CustomProgressDialog.hide();
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<bool> checkIfLoggedin() async {
    bool isLoggedIn = await sharedPref.readBool("isLoggedIn") ?? false;
    return isLoggedIn;
  }
}

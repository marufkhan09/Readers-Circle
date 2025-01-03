import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/models/login_response/login_response.dart';
import 'package:readers_circle/models/prerenences_model/prerenences_model.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';

class PrefProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  Status get status => _status;
  Status _status = Status.none;

  late PreferenceModel _preferences;

  PreferenceModel get preferences => _preferences;

  set preferences(PreferenceModel value) {
    _preferences = value;
  }

  late LoginResponse _loginResponse;

  LoginResponse get loginResponse => _loginResponse;

  set loginResponse(LoginResponse value) {
    _loginResponse = value;
  }

  //Preference list

  Future<PreferenceModel> getPreferences() async {
    try {
      final response = await getDio()!.get(categoriesPath);

      PreferenceModel? preferencesResponse =
          PreferenceModel.fromJson(response.data);
      _preferences = preferencesResponse;
      notifyListeners();

      return _preferences;
    } on DioException catch (e) {
      _preferences = PreferenceModel();
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Error fetching data");
      return _preferences;
    }
  }

  //set preferences of a user

  Future<int> setPreferences({
    required List<String> prefs,
    required String id,
  }) async {
    try {
      final response = await getDio()!
          .put("users/$id/set-preference", data: {"preferences[]   ": prefs});

      notifyListeners();
      return response.statusCode!;
    } on DioException catch (e) {
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Something went wrong");
      return e.response!.statusCode!;
    } finally {
      notifyListeners(); // Notify listeners that the data has changed
    }
  }

  Future<LoginResponse?> getSavedLoginResponse() async {
    final loginResponseString = await sharedPref.readString("loginResponse");
    if (loginResponseString != null) {
      final jsonMap = json.decode(loginResponseString) as Map<String, dynamic>;
      _loginResponse = LoginResponse.fromJson(jsonMap);
      notifyListeners();
      return _loginResponse;
    } else {
      _loginResponse = LoginResponse();
      notifyListeners();
      return null;
    }
  }
}

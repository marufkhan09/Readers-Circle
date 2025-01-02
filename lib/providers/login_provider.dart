import 'package:flutter/material.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/api/login_api_call.dart';
import 'package:readers_circle/utils/shared_pref.dart';

class LoginProvider extends ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  Status get status => _status;
  Status _status = Status.none;

  login({required phone, required password}) {
    _status = Status.loading;
    notifyListeners();
    LoginApiCall()
        .callApi(phone: phone, password: password)
        .then((response) {});
  }

  Future<bool> checkIfLoggedin() async {
    bool isLoggedIn = await sharedPref.readBool("isLoggedIn") ?? false;
    return isLoggedIn;
  }
}

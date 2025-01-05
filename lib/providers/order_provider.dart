import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';
import 'package:readers_circle/widgets/progressBar.dart';

class OrderProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  //registration

  Future<int> rentCall({
    required String id,
    required String startDatetime,
    required String endDatetime,
    required String addressName,
    required String street,
    required String postCode,
    required String district,
    required String type,
  }) async {
    CustomProgressDialog.show(message: "Loading...", isDismissible: false);
    try {
      final response = await getDio()!.post("books/$id/borrow", data: {
        'start_datetime': startDatetime,
        'end_datetime': endDatetime,
        'address[name]': addressName,
        'address[street_no]': street,
        'address[post_code]': postCode,
        'address[district]': district
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

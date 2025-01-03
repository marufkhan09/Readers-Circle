import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/api_paths.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
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

  //Preference list

  Future<PreferenceModel> getPreferences(
      {required int page, required String type}) async {
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
}

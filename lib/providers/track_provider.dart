import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/models/track_list_model/track_list_model.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';

class TrackProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  TrackListModel? _trackListModel;

  TrackListModel? get trackListModel => _trackListModel;

  set trackListModel(TrackListModel? value) {
    _trackListModel = value;
  }

  bool _isTracklistAvailable = false;

  bool get isTracklistAvailable => _isTracklistAvailable;

  set isTracklistAvailable(bool value) {
    _isTracklistAvailable = value;
  }

  bool _isBorrowlistavailable = false;

  bool get isBorrowlistavailable => _isBorrowlistavailable;

  set isBorrowlistavailable(bool value) {
    _isBorrowlistavailable = value;
  }

//borrowlist
  Future<TrackListModel> fetchBorrowlist() async {
    try {
      final response = await getDio()!.get(
        "books",
      );
      TrackListModel responseJson = TrackListModel.fromJson(response.data);
      _trackListModel = responseJson;
      _isBorrowlistavailable = true;
      notifyListeners();
      return _trackListModel!;
    } on DioException catch (e) {
      _trackListModel = TrackListModel();
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Error fetching data");
      return _trackListModel!;
    }
  }

  Future<TrackListModel> fetchOrderlist() async {
    try {
      final response =
          await getDio()!.get("track-list", queryParameters: {"buy": "true"});
      TrackListModel responseJson = TrackListModel.fromJson(response.data);
      _trackListModel = responseJson;
      _isBorrowlistavailable = true;
      notifyListeners();
      return _trackListModel!;
    } on DioException catch (e) {
      _trackListModel = TrackListModel();
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Error fetching data");
      return _trackListModel!;
    }
  }
}

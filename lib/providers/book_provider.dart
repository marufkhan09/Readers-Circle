import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/models/book_model/book_model.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';

class BookProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();

  Status get status => _status;
  Status _status = Status.none;

  late BookModel _booksForRent;

  BookModel get booksForRent => _booksForRent;

  set booksForRent(BookModel value) {
    _booksForRent = value;
  }

  late BookModel _booksForSale;

  BookModel get booksForSale => _booksForSale;

  set booksForSale(BookModel value) {
    _booksForSale = value;
  }

  bool _booksForRentLoaded = false;

  bool get booksForRentLoaded => _booksForRentLoaded;

  set booksForRentLoaded(bool value) {
    _booksForRentLoaded = value;
  }

  bool _booksForSaleLoaded  =false;

  bool get booksForSaleLoaded => _booksForSaleLoaded;

  set booksForSaleLoaded(bool value) {
    _booksForSaleLoaded = value;
  }

//books for rent
  Future<BookModel> fetchBooksForRent() async {
    try {
      final response = await getDio()!.get("books",queryParameters: {"for_rent": "true"});
      BookModel responseJson = BookModel.fromJson(response.data);
      _booksForRent = responseJson;
      _booksForRentLoaded = true;
      notifyListeners();
      return _booksForRent;
    } on DioException catch (e) {
      _booksForRent = BookModel();
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Error fetching data");
      return _booksForRent;
    }
  }

  //books for sale

  Future<BookModel> fetchBooksForSale() async {
    try {
      final response = await getDio()!.get("books",queryParameters: {"for_sale": "true"});
      BookModel responseJson = BookModel.fromJson(response.data);
      _booksForSale = responseJson;
      _booksForSaleLoaded = true;
      notifyListeners();
      return _booksForSale;
    } on DioException catch (e) {
      _booksForSale = BookModel();
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Error fetching data");
      return _booksForSale;
    }
  }
}

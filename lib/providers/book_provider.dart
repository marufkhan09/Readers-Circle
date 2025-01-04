import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/api/base_api_service.dart';
import 'package:readers_circle/models/book_detail_model/book_detail_model.dart';
import 'package:readers_circle/models/book_model/book_model.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';

class BookProvider extends BaseApiService with ChangeNotifier {
  final SharedPref sharedPref = SharedPref();


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

  bool _booksForSaleLoaded = false;

  bool get booksForSaleLoaded => _booksForSaleLoaded;

  set booksForSaleLoaded(bool value) {
    _booksForSaleLoaded = value;
  }

  BookDetailModel _bookDetail = BookDetailModel();

  BookDetailModel get bookDetail => _bookDetail;

  set bookDetail(BookDetailModel value) {
    _bookDetail = value;
  }

  bool _bookDetaillLoaded = false;

  bool get bookDetaillLoaded => _bookDetaillLoaded;

  set bookDetaillLoaded(bool value) {
    _bookDetaillLoaded = value;
  }

//books for rent
  Future<BookModel> fetchBooksForRent() async {
    try {
      final response =
          await getDio()!.get("books", queryParameters: {"for_rent": "true"});
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
      final response =
          await getDio()!.get("books", queryParameters: {"for_sale": "true"});
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

  //book details

  Future<BookDetailModel> bookDetails({required String id}) async {
    try {
      final response = await getDio()!.get("books/$id");
      BookDetailModel responseJson = BookDetailModel.fromJson(response.data);
      _bookDetail = responseJson;
      _bookDetaillLoaded = true;
      notifyListeners();
      return _bookDetail;
    } on DioException catch (e) {
      _bookDetail = BookDetailModel();
      debugPrint("Error: ${e.message}");
      notifyListeners();
      showMessageToast(message: "Error fetching data");
      return _bookDetail;
    }
  }




  // Future<int> registerCall({
  //   required String id
  // }) async {
  //   try {
  //     final response = await getDio()!.post("books/$id/borrow", data: {
  //       'first_name': fName,
  //       'last_name': lName,
  //       'email': email,
  //       'phone_number': phone,
  //       'account_type': "both"
  //     });

  //     final responseJson = json.decode(response.toString());
  //     showMessageToast(message: responseJson["message"]);
  //     _status = Status.success;
  //     notifyListeners();
  //     return response.statusCode!;
  //   } on DioException catch (e) {
  //     final responseJson = json.decode(e.response.toString());
  //     showMessageToast(message: responseJson["message"]);
  //     _status = Status.failed;
  //     notifyListeners();
  //     return e.response!.statusCode!;
  //   } finally {
  //     notifyListeners(); // Notify listeners that the data has changed
  //   }
  // }
}

import 'data.dart';

class BookDetailModel {
  String? message;
  int? code;
  Data? data;

  BookDetailModel({this.message, this.code, this.data});

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    return BookDetailModel(
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': data?.toJson(),
      };
}

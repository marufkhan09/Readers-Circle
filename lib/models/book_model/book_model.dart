import 'datum.dart';

class BookModel {
  String? message;
  int? code;
  List<BookDatum>? data;

  BookModel({this.message, this.code, this.data});

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        message: json['message'] as String?,
        code: json['code'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => BookDatum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

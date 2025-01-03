import 'datum.dart';

class PreferenceModel {
  String? message;
  int? code;
  List<CatDatum>? data;

  PreferenceModel({this.message, this.code, this.data});

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    return PreferenceModel(
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CatDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

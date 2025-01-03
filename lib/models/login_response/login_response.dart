import 'data.dart';

class LoginResponse {
  String? message;
  int? code;
  Data? data;

  LoginResponse({this.message, this.code, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json['message'] as String?,
        code: json['code'] as int?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': data?.toJson(),
      };
}

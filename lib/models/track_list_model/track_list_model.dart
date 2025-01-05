import 'datum.dart';

class TrackListModel {
  String? message;
  int? code;
  List<Datum>? data;

  TrackListModel({this.message, this.code, this.data});

  factory TrackListModel.fromJson(Map<String, dynamic> json) {
    return TrackListModel(
      message: json['message'] ?? "",
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

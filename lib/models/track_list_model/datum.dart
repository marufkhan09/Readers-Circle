import 'address.dart';
import 'book.dart';
import 'renter_information.dart';

class Datum {
  int? id;
  String? borrowUuid;
  Book? book;
  RenterInformation? renterInformation;
  Address? address;
  String? status;

  Datum({
    this.id,
    this.borrowUuid,
    this.book,
    this.renterInformation,
    this.address,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        borrowUuid: json['borrow_uuid'] ?? "",
        book: json['book'] == null
            ? null
            : Book.fromJson(json['book'] as Map<String, dynamic>),
        renterInformation: json['renter_information'] == null
            ? null
            : RenterInformation.fromJson(
                json['renter_information'] as Map<String, dynamic>),
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String, dynamic>),
        status: json['status'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'borrow_uuid': borrowUuid,
        'book': book?.toJson(),
        'renter_information': renterInformation?.toJson(),
        'address': address?.toJson(),
        'status': status,
      };
}

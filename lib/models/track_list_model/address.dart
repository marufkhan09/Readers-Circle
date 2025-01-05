class Address {
  String? name;
  String? streetNo;
  String? postCode;
  String? district;

  Address({this.name, this.streetNo, this.postCode, this.district});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json['name'] ?? "",
        streetNo: json['street_no'] ?? "",
        postCode: json['post_code'] ?? "",
        district: json['district'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'street_no': streetNo,
        'post_code': postCode,
        'district': district,
      };
}

class RenterInformation {
  String? name;
  String? email;
  String? phone;

  RenterInformation({this.name, this.email, this.phone});

  factory RenterInformation.fromJson(Map<String, dynamic> json) {
    return RenterInformation(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
      };
}

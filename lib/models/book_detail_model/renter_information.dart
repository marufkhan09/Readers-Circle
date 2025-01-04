class RenterInformation {
  String? name;
  String? email;
  String? phone;

  RenterInformation({this.name, this.email, this.phone});

  factory RenterInformation.fromJson(Map<String, dynamic> json) {
    return RenterInformation(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
      };
}

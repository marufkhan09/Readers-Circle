class Data {
  String? token;
  int? id;
  String? firstName;
  String? lastName;
  String? accountType;
  String? email;
  String? phoneNumber;
  List<String>? preferences;

  Data({
    this.token,
    this.id,
    this.firstName,
    this.lastName,
    this.accountType,
    this.email,
    this.phoneNumber,
    this.preferences,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'] as String?,
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        accountType: json['account_type'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phone_number'] as String?,
        preferences: json['preferences'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'account_type': accountType,
        'email': email,
        'phone_number': phoneNumber,
        'preferences': preferences,
      };
}

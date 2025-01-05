import 'renter_information.dart';
import 'subcategory.dart';

class Data {
  int? id;
  String? title;
  String? author;
  String? description;
  String? categoryName;
  bool? forRent;
  bool? availableForRent;
  double? rentPerHour;
  bool? availableForSell;
  double? price;
  int? categoryId;
  List<Subcategory>? subcategories;
  RenterInformation? renterInformation;

  Data({
    this.id,
    this.title,
    this.author,
    this.description,
    this.categoryName,
    this.forRent,
    this.availableForRent,
    this.rentPerHour,
    this.availableForSell,
    this.price,
    this.categoryId,
    this.subcategories,
    this.renterInformation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        title: json['title'] as String?,
        author: json['author'] as String?,
        description: json['description'] as String?,
        categoryName: json['category_name'] as String?,
        forRent: json['for_rent'] as bool?,
        availableForRent: json['available_for_rent'] as bool?,
        rentPerHour: json['rent_per_day'] ?? 0,
        availableForSell: json['available_for_sell'] as bool?,
        price: json['price'] ?? 0,
        categoryId: json['category_id'] as int?,
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        renterInformation: json['renter_information'] == null
            ? null
            : RenterInformation.fromJson(
                json['renter_information'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'category_name': categoryName,
        'for_rent': forRent,
        'available_for_rent': availableForRent,
        'rent_per_day': rentPerHour,
        'available_for_sell': availableForSell,
        'price': price,
        'category_id': categoryId,
        'subcategories': subcategories?.map((e) => e.toJson()).toList(),
        'renter_information': renterInformation?.toJson(),
      };
}

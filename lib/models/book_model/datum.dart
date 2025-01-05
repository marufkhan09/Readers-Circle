import 'subcategory.dart';

class BookDatum {
  int? id;
  String? title;
  String? author;
  String? description;
  String? categoryName;
  bool? forRent;
  bool? availableForRent;
  dynamic rentPerHour;
  bool? availableForSell;
  double? price;
  int? categoryId;
  List<Subcategory>? subcategories;

  BookDatum({
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
  });

  factory BookDatum.fromJson(Map<String, dynamic> json) => BookDatum(
        id: json['id'] as int?,
        title: json['title'] ?? "",
        author: json['author'] ?? "",
        description: json['description'] ?? "",
        categoryName: json['category_name'] ?? "",
        forRent: json['for_rent'] ?? false,
        availableForRent: json['available_for_rent'] ?? false,
        rentPerHour: json['rent_per_day'] ?? 0.0,
        availableForSell: json['available_for_sell'] ?? false,
        price: json['price'] ?? 0,
        categoryId: json['category_id'] as int?,
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
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
      };
}

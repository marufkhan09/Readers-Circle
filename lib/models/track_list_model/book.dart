import 'subcategory.dart';

class Book {
  String? title;
  String? author;
  String? description;
  String? categoryName;
  bool? forRent;
  bool? availableForRent;
  int? rentPerDay;
  bool? availableForSell;
  int? price;
  int? categoryId;
  int? totalRentCost;
  int? platformFee;
  List<Subcategory>? subcategories;

  Book({
    this.title,
    this.author,
    this.description,
    this.categoryName,
    this.forRent,
    this.availableForRent,
    this.rentPerDay,
    this.availableForSell,
    this.price,
    this.categoryId,
    this.totalRentCost,
    this.platformFee,
    this.subcategories,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json['title'] ?? "",
        author: json['author'] ?? "",
        description: json['description'] ?? "",
        categoryName: json['category_name'] ?? "",
        forRent: json['for_rent'] ?? false,
        availableForRent: json['available_for_rent'] ?? false,
        rentPerDay: json['rent_per_day'] ?? 0,
        availableForSell: json['available_for_sell'] ?? false,
        price: json['price'] ?? 0,
        categoryId: json['category_id'] ?? 0,
        totalRentCost: json['total_rent_cost'] ?? 0,
        platformFee: json['platform_fee'] ?? 0,
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'description': description,
        'category_name': categoryName,
        'for_rent': forRent,
        'available_for_rent': availableForRent,
        'rent_per_day': rentPerDay,
        'available_for_sell': availableForSell,
        'price': price,
        'category_id': categoryId,
        'total_rent_cost': totalRentCost,
        'platform_fee': platformFee,
        'subcategories': subcategories?.map((e) => e.toJson()).toList(),
      };
}

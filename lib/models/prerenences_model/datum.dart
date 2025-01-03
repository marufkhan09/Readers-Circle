class Datum {
  String? categoryName;
  List<String>? subcategories;

  Datum({this.categoryName, this.subcategories});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryName: json['category_name'] as String?,
        subcategories: json['subcategories'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        'category_name': categoryName,
        'subcategories': subcategories,
      };
}

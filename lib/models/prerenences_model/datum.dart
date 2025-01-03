class CatDatum {
  String? categoryName;
  List<dynamic>? subcategories;

  CatDatum({this.categoryName, this.subcategories});

  factory CatDatum.fromJson(Map<String, dynamic> json) => CatDatum(
        categoryName: json['category_name'] ?? "",
        subcategories: json['subcategories'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        'category_name': categoryName,
        'subcategories': subcategories,
      };
}

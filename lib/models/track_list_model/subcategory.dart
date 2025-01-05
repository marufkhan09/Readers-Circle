class Subcategory {
  int? id;
  String? name;

  Subcategory({this.id, this.name});

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

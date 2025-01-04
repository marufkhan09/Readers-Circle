class Subcategory {
  int? id;
  String? name;

  Subcategory({this.id, this.name});

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

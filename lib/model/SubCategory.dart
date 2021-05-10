class SubCategory {
  final int id;
  String name;
  int category_id;

  SubCategory({this.id, this.name, this.category_id});

  factory SubCategory.fromJson(Map<String, dynamic> data) => new SubCategory(
        id: data["id"],
        name: data["name"],
        category_id: data["category_id"],
      );

  Map<String, dynamic> toJson() => {"name": name, "category_id": category_id};
}

import 'dart:typed_data';

class Product {
  final int id;
  String name;
  int category_id;
  int sub_category_id;
  String description;
  int price;
  Uint8List image;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.sub_category_id,
      this.category_id,
      this.image});

  factory Product.fromJson(Map<String, dynamic> data) => new Product(
        id: data["id"],
        name: data["name"],
        category_id: data["category_id"],
        sub_category_id: data["sub_category_id"],
        description: data["description"],
        price: data["price"],
        image: data["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category_id": category_id,
        "sub_category_id": sub_category_id,
        "description": description,
        "price": price,
        "image": image
      };
}

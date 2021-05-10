class Category {
   int id;
   String name;

  Category({this.id, this.name,});



   factory Category.fromJson(Map<String, dynamic> data) => new Category(
     id: data["id"],
     name: data["name"],
   );

   Map<String, dynamic> toJson() => {
     "id": id,
     "name": name,
   };

}

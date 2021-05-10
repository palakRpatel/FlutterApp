import 'package:jaibahuchar/database/DBProvider.dart';
import 'package:jaibahuchar/model/Category.dart';
import 'package:jaibahuchar/model/Product.dart';
import 'package:jaibahuchar/model/SubCategory.dart';

class DBQueries {
  var _database;
  DBProvider dbProvider;

  DBQueries() {
    getDb();
  }

  getDb() async {
    /// Initialize sq-lite
    dbProvider = await DBProvider();
  }

  initializeDB() async {
    _database = await dbProvider.initDB();
  }

  Future<int> createCategory(Category category) async {
    var result = await _database.insert("Category", category.toJson());
    return result;
  }

  Future<int> addProduct(Product product) async {
    var result = await _database.insert("Product", product.toJson());
    return result;
  }

  Future<int> addSubCategory(SubCategory subCategory) async {
    var result = await _database.insert("SubCategory", subCategory.toJson());
    return result;
  }

  Future<List> getCategory() async {
    var result = await _database.rawQuery('SELECT * FROM Category');
    return result.toList();
  }

  Future<Category> getCategoryById(int id) async {
    var results =
        await _database.rawQuery('SELECT * FROM Category WHERE id = $id');

    if (results.length > 0) {
      return new Category.fromJson(results.first);
    }

    return null;
  }

  Future<int> updateCategory(Category category) async {
    return await _database.rawUpdate(
        'UPDATE Category SET name = ${category.name} WHERE id = ${category.id}');
  }

  Future<int> deleteCategory(int id) async {
    return await _database.rawDelete('DELETE FROM Category WHERE id = $id');
  }

  Future<int> deleteProduct(int id) async {
    return await _database.rawDelete('DELETE FROM Product WHERE id = $id');
  }

  Future<List> getProductBySubCategoryId(int id) async {
    var results = await _database
        .rawQuery('SELECT * FROM Product WHERE sub_category_id = $id');

    if (results.length > 0) {
      return results.toList();
    }

    return null;
  }

  Future<List> getSubCategory(int id) async {
    var result = await _database
        .rawQuery('SELECT * FROM SubCategory WHERE category_id = $id');
    return result.toList();
  }

  closedatabase() async {
    await _database.close();
  }
}

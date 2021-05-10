import 'dart:io';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import 'package:jaibahuchar/Components/MyCircularImage.dart';
import 'package:jaibahuchar/database/DBQueries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaibahuchar/model/Category.dart';
import 'package:jaibahuchar/model/Product.dart';
import 'package:jaibahuchar/model/SubCategory.dart';
import 'AppColor.dart';

void main() {
  runApp(AddProductScreen());
}

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Add Product",
      theme: ThemeData(primaryColor: darkBlue),
      home: MyHomePage(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyDescriptionPage createState() => MyDescriptionPage();
}

class MyDescriptionPage extends State<MyHomePage> {
  Category dropdownCategoryValue;

  SubCategory dropdownSubCategoryValue;
  final txtProductName = TextEditingController();
  final txtProductDesc = TextEditingController();
  final txtPrice = TextEditingController();
  final txtSubCategory = TextEditingController();
  File _image;

  DBQueries db;
  List<Category> categories = new List<Category>();
  List<SubCategory> subCategories = new List<SubCategory>();

  Future<void> _accessDatabase() async {
    db = await DBQueries();
    await db.initializeDB();
    _getCategories();
    _getSubcategories(1);
  }

  Future<void> _getCategories() async {
    var cat = await db.getCategory();
    for (int i = 0; i < cat.length; i++) {
      categories.add(Category.fromJson(cat[i]));
      dropdownCategoryValue = categories[0];
    }
  }

  Future<void> _getSubcategories(int id) async {
    setState(() async {
      var subCat = await db.getSubCategory(id);
      subCategories.clear();
      for (int i = 0; i < subCat.length; i++) {
        setState(() {
          subCategories.add(SubCategory.fromJson(subCat[i]));
          dropdownSubCategoryValue = subCategories[0];
          print("table count" + SubCategory.fromJson(subCat[i]).name);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _accessDatabase();
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add SubCategory'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: txtSubCategory,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Sub Category Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                String name = txtSubCategory.text.toString();
                SubCategory subCat = new SubCategory();
                if (!name.isEmpty) {
                  subCat.category_id = dropdownCategoryValue.id;
                  subCat.name = name;
                  db.addSubCategory(subCat);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Subcategory Added"),
                  ));
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    _imgFromGallery();
                  },
                  child: MyCircularImage(
                      image:
                          (_image == null ? null : _image.readAsBytesSync()))),
              DropdownButton<Category>(
                hint: Text("Categories"),
                value: dropdownCategoryValue,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down_sharp),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: darkBlue,
                ),
                onChanged: (Category newValue) {
                  setState(() {
                    dropdownCategoryValue = newValue;
                    _getSubcategories(dropdownCategoryValue.id);
                  });
                },
                items: categories
                    .map<DropdownMenuItem<Category>>((Category value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DropdownButton<SubCategory>(
                        hint: Text("Sub Categories"),
                        value: dropdownSubCategoryValue,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                        iconSize: 30,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: darkBlue,
                        ),
                        onChanged: (SubCategory newValue) {
                          setState(() {
                            dropdownSubCategoryValue = newValue;
                          });
                        },
                        items: subCategories.map<DropdownMenuItem<SubCategory>>(
                            (SubCategory value) {
                          return DropdownMenuItem<SubCategory>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _showMyDialog();
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: txtProductName,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Product Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: txtProductDesc,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Product Description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: txtPrice,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Product Price',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.lightBlue,
                  child: Text("Save"),
                  onPressed: () {
                    saveProduct();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      _image = image;
    });
  }

  void saveProduct() {
    String name = txtProductName.text.toString();
    String desc = txtProductDesc.text.toString();
    String price = txtPrice.text.toString();
    Product product = new Product();
    if (!name.isEmpty && !desc.isEmpty && !price.isEmpty) {
      product.name = name;
      product.description = desc;
      product.price = int.parse(price);
      product.category_id = dropdownCategoryValue.id;
      product.sub_category_id = dropdownSubCategoryValue.id;
      product.image = _image.readAsBytesSync();
      db.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Added"),
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please add all fields")));
    }
  }
}

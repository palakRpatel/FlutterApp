import 'dart:ui';

import 'package:jaibahuchar/Components/ProductListItem.dart';
import 'package:jaibahuchar/Components/CategoryListItem.dart';
import 'package:jaibahuchar/Components/SubCategoryItem.dart';
import 'package:jaibahuchar/database/DBQueries.dart';
import 'package:jaibahuchar/model/Category.dart';
import 'package:jaibahuchar/model/Product.dart';
import 'package:jaibahuchar/model/SubCategory.dart';
import 'package:jaibahuchar/ui/AddProductScreen.dart';
import 'package:jaibahuchar/ui/detailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreenUI extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Jai Bahuchar Electronics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<SubCategory> subCategories = new List<SubCategory>();
  List<Product> products = new List<Product>();
  List<Category> categories = new List<Category>();

  DBQueries db;

  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.8);

  PageController _categoryController =
      PageController(initialPage: 0, viewportFraction: 0.12);

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  Future<void> _accessDatabase() async {
    db = await DBQueries();
    await db.initializeDB();
    _getCategories();
    _getSubCategories(1);
    _getProducts(1);
  }

  Future<void> _getSubCategories(int id) async {
    var subCat = await db.getSubCategory(id);
    subCategories.clear();
    for (int i = 0; i < subCat.length; i++) {
      setState(() {
        subCategories.add(SubCategory.fromJson(subCat[i]));
      });
      print("table count" + SubCategory.fromJson(subCat[i]).name);
    }
  }

  Future<void> _getCategories() async {
    var cat = await db.getCategory();
    for (int i = 0; i < cat.length; i++) {
      categories.add(Category.fromJson(cat[i]));
      print("table count" + Category.fromJson(cat[i]).name);
    }
  }

  Future<void> _getProducts(int id) async {
    var product = await db.getProductBySubCategoryId(id);
    products.clear();
    for (int i = 0; i < product.length; i++) {
      setState(() {
        products.add(Product.fromJson(product[i]));
      });
      print("table count" + Product.fromJson(product[i]).name);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _accessDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddProductScreen()));
            }),
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi Palak',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, size: 30.0),
                  )
                ],
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                itemCount: categories.length,
                itemExtent: 100.0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  return GestureDetector(
                    child: CategoryListItem(
                      category: categories[i],
                    ),
                    onTap: () {
                      _getSubCategories(categories[i].id);
                    },
                  );
                },
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                itemCount: subCategories.length,
                itemExtent: 80.0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  return GestureDetector(
                    child: SubCategoryItem(
                      subCategory: subCategories[i],
                    ),
                    onTap: () {
                      _getProducts(subCategories[i].id);
                    },
                  );
                },
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(left:16.0,right: 16.0,bottom: 20.0),
                shrinkWrap: true,
                itemCount: products.length,
                itemExtent: 100.0,
                itemBuilder: (c, i) {
                  return GestureDetector(
                    child: ProductListItem(product: products[i]),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailScreen(products[i])));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

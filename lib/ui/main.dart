import 'dart:ui';

import 'package:jaibahuchar/database/DBQueries.dart';
import 'package:jaibahuchar/model/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/rahul/Palak_stuff/Flutter/flutter_projects/jaibahuchar/lib/ui/AppColor.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Category> categories = new List<Category>();

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

    var db = await DBQueries();
    await db.initializeDB();
    var category = await db.getCategory();
    for (int i = 0; i < category.length; i++) {
        categories.add(Category.fromJson(category[0]));
    }
    print("table count" + Category.fromJson(category[0]).name);
  }

  List<Category> _getCategory() {
    return categories;
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
              height: 200,
              width: double.infinity,
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/images/viewpager1.png'),
                              fit: BoxFit.cover),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/images/viewpage2.jpg'),
                              fit: BoxFit.cover),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/images/viewpager1.png'),
                              fit: BoxFit.cover),
                        ),
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                Text(
                  "see more",
                  style: TextStyle(fontSize: 15.0, color: textOrange),
                )
              ],
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightOrange,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                        Text(categories[0].name)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(Icons.hearing_rounded),
                        ),
                        Text("Ear")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(Icons.ac_unit_rounded),
                        ),
                        Text("Skin")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(Icons.access_alarm_outlined),
                        ),
                        Text("Legs")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                        Text("Hands")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lightBlue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(Icons.account_balance),
                        ),
                        Text("Lips")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Higlights",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                Text("See More",
                    style: TextStyle(fontSize: 15.0, color: textOrange)),
              ],
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/makeover.png')),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Makeup Tips",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "30 Likes",
                              style: TextStyle(
                                  color: textOrange,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/fashion.png')),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Makeup Tips",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "30 Likes",
                              style: TextStyle(
                                  color: textOrange,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/makeup.png')),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Makeup Tips",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "30 Likes",
                              style: TextStyle(
                                  color: textOrange,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                itemCount: 100,
                itemExtent: 100.0,
                itemBuilder: (c, i) {
                  return Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: lightOrange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image(
                                    height: 40,
                                    image:
                                        AssetImage('assets/images/makeup.png')),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 30.0, left: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Makeup Tips",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "30 Likes",
                                    style: TextStyle(
                                        color: textOrange,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star_rate_outlined,
                            color: darkPink,
                            size: 25.0,
                          ),
                        )
                      ],
                    ),
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

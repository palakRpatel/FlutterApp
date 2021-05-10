import 'package:jaibahuchar/model/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaibahuchar/ui/AppColor.dart';

class CategoryListItem extends StatelessWidget {
  Category category;

  CategoryListItem({Key key, this.title, this.category}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
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
            child:  Image(
                height: 40,
                image:
                AssetImage('assets/images/elect1.jpg')),
          ),
          Text(category.name)
        ],
      ),
    );
  }

}

import 'dart:io';
import 'dart:ui';

import 'package:jaibahuchar/Components/MyCircularImage.dart';
import 'package:jaibahuchar/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaibahuchar/ui/AppColor.dart';

class ProductListItem extends StatelessWidget {
  Product product;
  File image = null;

  ProductListItem({Key key, this.title, this.product}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (product.image != null) {
      image = File.fromRawPath(product.image);
    }

    Widget CircularImage = MyCircularImage(image: (() {
      if (product.image != null) {
        return product.image;
      }
    })());

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
              CircularImage,
              Container(
                margin: const EdgeInsets.only(top: 30.0, left: 8.0),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "30 Likes",
                      style: TextStyle(
                          color: textOrange, fontWeight: FontWeight.w500),
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
  }
}

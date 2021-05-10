import 'dart:io';
import 'dart:typed_data';

import 'package:jaibahuchar/model/Category.dart';
import 'package:jaibahuchar/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaibahuchar/ui/AppColor.dart';

class MyCircularImage extends StatelessWidget {
  Uint8List image;

  MyCircularImage({Key key, this.title, this.image}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return CircleAvatar(
      radius: 25,
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.memory(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.fitHeight,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25)),
              width: 50,
              height: 50,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[800],
              ),
            ),
    );
  }
}

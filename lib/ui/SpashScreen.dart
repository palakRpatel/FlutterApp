import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaibahuchar/ui/HomeScreenUI.dart';



void main() {
  runApp(SplashScreen());
}
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash(),debugShowCheckedModeBanner: false);
        } else {
          return MaterialApp(
            home: HomeScreenUI(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.apartment_outlined,
          size: MediaQuery.of(context).size.width * 0.785,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterpaymentgateway/screens/existing_card.dart';
import 'package:flutterpaymentgateway/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.name,
      routes: {
        HomePage.name: (_) => HomePage(),
        ExistingCardPage.name: (_) => ExistingCardPage(),
      },
    );
  }
}

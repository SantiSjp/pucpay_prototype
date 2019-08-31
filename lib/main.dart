import 'package:flutter/material.dart';
import 'pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUCpay',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


import 'package:disenoapp/controller/Auth.dart';
import 'package:disenoapp/controller/rootController.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Floristeria',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: RootPage( auth: Auth(), ),
    );
  }
}

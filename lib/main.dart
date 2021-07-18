import 'package:devel_app/screens/articles_screen.dart';
import 'package:devel_app/utils/material_color.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: createMaterialColor(Color.fromRGBO(43, 49, 77, 1)),
      ),
      home: ArticlesScreen(),
    );
  }
}

import 'dart:io';

import 'package:devel_app/providers/readings.dart';
import 'package:devel_app/widgets/drawer.dart';
import 'package:devel_app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadingsScreen extends StatelessWidget {
  static const routeName = "/readings";
  var readings;
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
    final isBook = arguments["isBook"];
    if (isBook!) {
      readings = Provider.of<Readings>(context).books();
    } else {
      readings = Provider.of<Readings>(context).articles();
    }
    print(readings.length);
    return Scaffold(
      appBar: AppBar(
        title: isBook ? Text("Kitoblar"): Text("Maqolalar"),
      ),
      drawer: MainDrawer(),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: readings.length,
          itemBuilder: (ctx, index) {
            return ListItem(
              context,
              readings[index],
            );
          },
        ),
      ),
    );
  }
}

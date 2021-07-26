import 'dart:io';

import 'package:devel_app/providers/readings.dart';
import 'package:devel_app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadingsScreen extends StatelessWidget {
  final isBook;
  var readings;
  ReadingsScreen(this.isBook);
  @override
  Widget build(BuildContext context) {
    if (isBook) {
      readings = Provider.of<Readings>(context).books();
    } else {
      readings = Provider.of<Readings>(context).articles();
    }
    print(readings.length);
    return Container(
      height: 500,
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
    );
  }
}

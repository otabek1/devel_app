import 'package:devel_app/providers/articles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Articles>(context).getArticles();

    return Scaffold(
      appBar: AppBar(
        title: Text("Maqolalar"),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Center(child: Text("testgit"),),
      ),
    );
  }
}

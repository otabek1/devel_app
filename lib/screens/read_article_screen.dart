import 'package:devel_app/providers/articles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadArticleScreen extends StatelessWidget {
  static const routeName = "/read-article";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final article = Provider.of<Articles>(context)
        .articles()
        .firstWhere((element) => element.id == id);

    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 20,
        child: SingleChildScrollView(
          child: Flexible(
            child: Text(
              article.content,
              style: TextStyle(
                fontSize: 16,
                letterSpacing: .8,
                height: 1.5,
              ),
              // locale: Locale("uz"),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}

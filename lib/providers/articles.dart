import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String title;
  final String content;
  final List<String> authors;
  final DateTime publishDate;

  Article(
      {required this.title,
      required this.content,
      required this.authors,
      required this.publishDate});
}

class Articles with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference articlesReference =
      FirebaseFirestore.instance.collection("articles");

  List<Article> _articles = [];

  void getArticles() {
    var test = articlesReference.get();
    print(test);
  }

  List<Article> articles() {
    return [..._articles];
  }
}

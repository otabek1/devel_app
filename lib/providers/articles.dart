import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime publishDate;

  Article(
      {required this.id,
      required this.title,
      required this.content,
      required this.author,
      required this.publishDate});
}

class Articles with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference articlesReference =
      FirebaseFirestore.instance.collection("articles");

  List<Article> _articles = [];

  Future<void> getArticles() async {
    var snapshot = await articlesReference.get();
    var docChanges = snapshot.docChanges;
    addArticle(docChanges);
  }

  void addArticle(List<DocumentChange<Object?>> docChanges) {
    docChanges.forEach((docChange) {
      Map<String, dynamic> data = docChange.doc.data() as Map<String, dynamic>;

      var _article = Article(
          id: docChange.doc.id,
          title: data["title"],
          content: data["content"],
          author: (data["author"]),
          publishDate: data["publishDate"].toDate());
      var _isAvailable =
          _articles.indexWhere((element) => element.id == _article.id);
      if (_isAvailable == -1) {
        _articles.add(_article);
      }
    });
    notifyListeners();

    return null;
    // _articles.add(_article);
  }

  List<Article> articles() {
    getArticles();
    return [..._articles];
  }
}

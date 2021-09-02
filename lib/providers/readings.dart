import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devel_app/helpers/reading_db.dart';
import 'package:flutter/cupertino.dart';

class Reading {
  String id;
  String title;
  String url;
  String author;
  String path;
  int isBook;

  Reading(
      {required this.id,
      required this.title,
      required this.author,
      required this.url,
      required this.isBook,
      this.path = ""});

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "url": url,
        "isBook": isBook,
        "path": path
      };

  static Reading fromJson(Map<String, dynamic> json) => Reading(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        url: json["url"],
        isBook: json["isBook"],
        path: json["path"],
      );
}

class Readings with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference readingsReference =
      FirebaseFirestore.instance.collection("readings");

  List<Reading> _readings = [];

  Future<List<Reading>> get readings async {
    await getAndSetData();
    // sleep(Duration(seconds: 2));
    print("readings ${_readings}");
    return _readings;

    // notifyListeners();
  }

  Future<void> getAndSetData() async {
    print("calling get and set");
    var data = await ReadingDb.getData();
    var fromFirebase = await getReadingFromFirebase();

    data.forEach((element) {
      var fromJson = Reading.fromJson(element);
      if (_readings.indexWhere((element) => element.id == fromJson.id) == -1) {
        _readings.add(fromJson);
      }
    });
    fromFirebase.forEach((fireaseElement) {
      if (_readings.indexWhere((element) => element.id == fireaseElement.id) ==
          -1) {
        _readings.add(fireaseElement);
      }
    });

    // notifyListeners();
    print("readings ${_readings}");
  }

  Future<List<Reading>> getReadingFromFirebase() async {
    List<Reading> readingsFromFirebase = [];
    var value = await readingsReference.get();

    value.docs.forEach((element) {
      var data = element.data();
      // print("data $data");
      var fromJson = Reading.fromJson(data as Map<String, dynamic>);
      if (_readings.indexWhere((element) => element.id == fromJson.id) == -1) {
        readingsFromFirebase.add(fromJson);
      }
    });

    if (readingsFromFirebase.isNotEmpty) {
      readingsFromFirebase.forEach((element) async {
        await ReadingDb.insert(element);
      });
    }
    return readingsFromFirebase;
  }

  Future<void> updatePath(Reading reading) async {
    print("updating path ${reading.path}");
    await ReadingDb.insert(reading);
  }
}

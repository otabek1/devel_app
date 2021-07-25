import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Reading {
  String id;
  String title;
  String url;
  String author;
  double sizeInMb;
  String path;

  Reading(
      {required this.id,
      required this.title,
      required this.author,
      required this.url,
      required this.sizeInMb,
      this.path = ""});
}

class Readings with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference articlesReference =
      FirebaseFirestore.instance.collection("readings");

  List<Reading> _readings = [];

  List<Reading> readings() {
    // print("readings >>>> ${_readings.length}");
    if (_readings.isEmpty) {
      getReadings();

      return _readings;
    } else {
      return _readings;
    }
  }

  void addReadingPath(String id, String path) {
    var index = _readings.indexWhere((element) => element.id == id);
    if (index != -1) {
      _readings[index] = Reading(
          id: id,
          title: _readings[index].title,
          author: _readings[index].author,
          url: _readings[index].url,
          sizeInMb: _readings[index].sizeInMb,
          path: path);
    }
    notifyListeners();
  }

  void getReadings() async {
    var snapshot = await articlesReference.get();
    var docChanges = snapshot.docChanges;
    addReading(docChanges);
  }

  Reading findById(String id) {
    return _readings.firstWhere((element) => element.id == id);
  }

  void addReading(List<DocumentChange<Object?>> docChanges) {
    docChanges.forEach((docChange) {
      Map<String, dynamic> data = docChange.doc.data() as Map<String, dynamic>;
      // print(data);
      var reading = Reading(
          id: docChange.doc.id,
          title: data["title"],
          sizeInMb: data["sizeInMb"],
          author: (data["author"]),
          url: data["url"]);
      var _isAvailable =
          _readings.indexWhere((element) => element.id == reading.id);
      if (_isAvailable == -1) {
        _readings.add(reading);
      }
    });
  }
}

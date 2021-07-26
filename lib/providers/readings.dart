import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devel_app/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';

class Reading {
  String id;
  String title;
  String url;
  String author;
  double sizeInMb;
  String path;
  int isBook;

  Reading(
      {required this.id,
      required this.title,
      required this.author,
      required this.url,
      required this.sizeInMb,
      required this.isBook,
      this.path = ""});
}

class Readings with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference articlesReference =
      FirebaseFirestore.instance.collection("readings");
  var _isFirst = true;
  List<Reading> _readings = [];

  List<Reading> books() {
    // print("readings >>>> ${_readings.length}");
    if (_readings.isEmpty) {
      getReadings();
      fetchAndSetPath();

      return [..._readings.where((element) => element.isBook==1).toList()];
    } else {
      print("fetching data");
      fetchAndSetPath();
      print("finished fetching data");
      return [..._readings.where((element) => element.isBook == 1).toList()];
    }
  }
  List<Reading> articles() {
    // print("readings >>>> ${_readings.length}");
    if (_readings.isEmpty) {
      getReadings();
      fetchAndSetPath();

      return [..._readings.where((element) => element.isBook==0).toList()];
    } else {
      print("fetching data");
      fetchAndSetPath();
      print("finished fetching data");
      return [..._readings.where((element) => element.isBook == 0).toList()];
    }
  }

  Future<void> fetchAndSetPath() async {
    try {
      print("try");
      final dataList = await DBHelper.getData("Readings");
      print("tried $dataList");

      dataList.forEach((item) {
        var id = item["id"];
        var index = _readings.indexWhere((element) => element.id == id);

        if (index != -1) {
          _readings[index] = Reading(
            id: id,
            title: _readings[index].title,
            author: _readings[index].author,
            url: _readings[index].url,
            sizeInMb: _readings[index].sizeInMb,
            isBook: _readings[index].isBook,
            path: item["path"],
          );
          print("PATH FROM SQL ${item["path"]}");
        }
        if (_isFirst) {
          notifyListeners();
          _isFirst = !_isFirst;
        }
      });
    } catch (e) {
      print("Catch ${e.toString()}");
      _readings.forEach((element) {
        print("PATh FROM SQLSS ${element.path}");
      });
    }
  }

  void addReadingPath(String id, String path) {
    var index = _readings.indexWhere((element) => element.id == id);
    if (index != -1) {
      DBHelper.updatePath(id, path.toString());

      _readings[index] = Reading(
          id: id,
          title: _readings[index].title,
          author: _readings[index].author,
          url: _readings[index].url,
          sizeInMb: _readings[index].sizeInMb,
          isBook: _readings[index].isBook,
          path: path.toString());
    }

    notifyListeners();
  }

  void getReadings() async {
    var snapshot = await articlesReference.get();

    print("snapsot>>>> ${snapshot.docChanges[0].doc.id}");
    if (snapshot.docChanges.isNotEmpty) {
      var docChanges = snapshot.docChanges;
      addReading(docChanges);
    }
  }

  Reading findById(String id) {
    return _readings.firstWhere((element) => element.id == id);
  }

  void addReading(List<DocumentChange<Object?>> docChanges) {
    docChanges.forEach((docChange) {
      Map<String, dynamic> data = docChange.doc.data() as Map<String, dynamic>;
      // print(data);
      // if (_readings.indexWhere((element) => element.id == docChange.doc.id) !=
      //     -1) {}
      var reading = Reading(
        id: docChange.doc.id,
        title: data["title"],
        sizeInMb: data["sizeInMb"],
        author: (data["author"]),
        isBook: data["isBook"],
        url: data["url"],
      );

      print("Readings ${_readings}");
      var _isAvailable =
          _readings.indexWhere((element) => element.id == reading.id);
      print("IsAvailable ${_isAvailable}");
      if (_isAvailable == -1) {
        print("addding +++++");
        _readings.add(reading);
        DBHelper.insert("Readings", {
          "id": docChange.doc.id,
          "title": data["title"],
          "sizeInMb": data["sizeInMb"],
          "author": (data["author"]),
          "url": data["url"],
          "isBook":data["isBook"]
        });
      }
    });
  }
}

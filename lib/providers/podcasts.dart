import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devel_app/helpers/db_helper.dart';
import 'package:flutter/foundation.dart';

class Podcast {
  String id;
  String title;
  String url;
  String path;

  Podcast(this.id, this.title, this.url, this.path);
}

class Podcasts with ChangeNotifier {
  bool _isFirst = true;
  List<Podcast> _podcasts = [];

  List<Podcast> podcasts() {
    if (_podcasts.isEmpty) {
      getPodcasts();
      fetchAndSetPath();
      return _podcasts;
    } else {
      fetchAndSetPath();
      return _podcasts;
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference articlesReference =
      FirebaseFirestore.instance.collection("podcasts");

  void getPodcasts() async {
    var snapshot = await articlesReference.get();

    if (snapshot.docChanges.isNotEmpty) {
      var docChanges = snapshot.docChanges;
      addPodcast(docChanges);
      fetchAndSetPath();
    }
  }

  void addPodcastPath(String id, String path) {
    var index = _podcasts.indexWhere((element) => element.id == id);
    if (index != -1) {
      print("updating path");
      DBHelper.updatePath("Podcasts", id, path.toString())
          .then((value) => fetchAndSetPath());

      _podcasts[index] = Podcast(
          id, _podcasts[index].title, _podcasts[index].url, path.toString());
      print(_podcasts[index].toString());
    }

    notifyListeners();
  }

  Future<void> fetchAndSetPath() async {
    try {
      print("try");
      final dataList = await DBHelper.getData("Podcasts");
      print("tried $dataList");

      dataList.forEach((item) {
        var id = item["id"];
        var index = _podcasts.indexWhere((element) => element.id == id);

        if (index != -1) {
          if (item["path"] == null) {
            _podcasts[index] =
                Podcast(id, _podcasts[index].title, _podcasts[index].url, "");
          } else {
            _podcasts[index] =
                Podcast(id, _podcasts[index].title, _podcasts[index].url, "");
          }
          // print("PATH FROM SQL ${item["path"]}");
        }

        _podcasts.forEach((element) {
          print("PATH >>> ${element.path}");
        });
        if (_isFirst) {
          notifyListeners();
          _isFirst = !_isFirst;
        } else {
          // _isFirst = !_isFirst;
        }
      });
    } catch (e) {
      print("Catch ${e.toString()}");
      _podcasts.forEach((element) {
        print("PATh FROM SQLSS ${element.path}");
      });
    }
  }

  Podcast findById(String id) {
    return _podcasts.firstWhere((element) => element.id == id);
  }

  void notify() {
    notifyListeners();
  }

  void addPodcast(List<DocumentChange<Object?>> docChanges) {
    docChanges.forEach((docChange) {
      Map<String, dynamic> data = docChange.doc.data() as Map<String, dynamic>;
      // print(data);
      // if (_podcasts.indexWhere((element) => element.id == docChange.doc.id) !=
      //     -1) {}
      var podcast = Podcast(docChange.doc.id, data["title"], data["url"], "");

      var _isAvailable =
          _podcasts.indexWhere((element) => element.id == podcast.id);
      if (_isAvailable == -1) {
        print("addding +++++");
        _podcasts.add(podcast);

        // DBHelper.isAvailable("Podcasts", podcast.id);
        DBHelper.insert("Podcasts", {
          "id": docChange.doc.id,
          "title": data["title"],
          "url": data["url"],
        });
      }
    });
  }
}

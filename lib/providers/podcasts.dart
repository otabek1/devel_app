import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devel_app/helpers/podcast_db.dart';
import 'package:flutter/foundation.dart';

class Podcast {
  String id;
  String title;
  String url;
  String path;

  Podcast(this.id, this.title, this.url, this.path);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "path": path,
      };

  static Podcast fromJson(Map<String, dynamic> json) =>
      Podcast(json["id"], json["title"], json["url"], json["path"]);
}

class Podcasts with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference PodcastsReference =
      FirebaseFirestore.instance.collection("podcasts");

  List<Podcast> _podcasts = [];

  Future<List<Podcast>> get podcasts async {
    await getAndSetData();
    return _podcasts;
  }

  Future<void> getAndSetData() async {
    print("calling get and set");
    var data = await PodcastDb.getData();
    var fromFirebase = getPodcastFromFirebase();

    data.forEach((element) {
      var fromJson = Podcast.fromJson(element);
      if (_podcasts.indexWhere((element) => element.id == fromJson.id) == -1) {
        _podcasts.add(fromJson);
      }
    });
    fromFirebase.forEach((fireaseElement) {
      if (_podcasts.indexWhere((element) => element.id == fireaseElement.id) ==
          -1) {
        _podcasts.add(fireaseElement);
      }
    });

    // notifyListeners();
  }

  List<Podcast> getPodcastFromFirebase() {
    List<Podcast> podcastsFromFirebase = [];
    PodcastsReference.get().then((value) {
      value.docs.forEach((element) {
        var data = element.data();
        // print("data $data");
        var fromJson = Podcast.fromJson(data as Map<String, dynamic>);
        if (_podcasts.indexWhere((element) => element.id == fromJson.id) ==
            -1) {
          podcastsFromFirebase.add(fromJson);
        }
      });

      if (podcastsFromFirebase.isNotEmpty) {
        podcastsFromFirebase.forEach((element) async {
          await PodcastDb.insert(element);
        });
      }
      return podcastsFromFirebase;
    });

    return [];
  }

  Future<void> updatePath(Podcast podcast) async {
    print("updating path ${podcast.path}");
    await PodcastDb.insert(podcast);
  }
}

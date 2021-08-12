import 'package:devel_app/providers/podcasts.dart';
import 'package:devel_app/widgets/drawer.dart';
import 'package:devel_app/widgets/podcast_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PodcastsScreen extends StatelessWidget {
  static const routeName = "/podcasts";
  var podcasts;
  var body;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Podcasts>(context).podcasts,
      builder: (BuildContext context, AsyncSnapshot<List<Podcast>> data) {
        if (data.hasError) {
          print(" error >> ${data.error.toString()}");
          body = Center(
            child: Text("Qandaydir xatolik yuz berdi. Qaytdan urinib ko'ring"),
          );
        } else if (data.hasData) {
          if (data.data != null) {
            podcasts = data.data;
            body = Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  padding: const EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: podcasts.length,
                    itemBuilder: (ctx, index) {
                      return PodcastItem(
                        context,
                        podcasts[index],
                      );
                    },
                  ),
                ),
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/devellapp.appspot.com/o/reklama.png?alt=media&token=d99baa92-a9dd-480a-aed1-31ed519d74ff",
                  fit: BoxFit.fill,
                  height: 100,

                  // width: MediaQuery.of(context).size.width,
                ),
              ],
            );
          }
        } else if (data.connectionState == ConnectionState.waiting) {
          body = Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text("Yuklanmoqda ...")),
                ],
              ),
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("Podkastlar"),
            ),
            drawer: MainDrawer(),
            body: body);
      },
    );
  }
}

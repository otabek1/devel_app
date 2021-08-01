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
          podcasts = data.data;
          body = Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(5),
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
          );
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

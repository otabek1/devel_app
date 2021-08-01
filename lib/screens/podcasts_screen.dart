import 'package:devel_app/providers/podcasts.dart';
import 'package:devel_app/widgets/drawer.dart';
import 'package:devel_app/widgets/podcast_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PodcastsScreen extends StatelessWidget {
  static const routeName = "/podcasts";
  @override
  Widget build(BuildContext context) {
    final podcasts = Provider.of<Podcasts>(context).podcasts();

    return Scaffold(
      appBar: AppBar(
        title: Text("Podkastlar"),
      ),
      drawer: MainDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: podcasts.length,
          itemBuilder: (ctx, index) {
            return PodcastItem(
              context,
              podcasts[index].id,
            );
          },
        ),
      ),
    );
  }
}

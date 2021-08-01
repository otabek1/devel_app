import 'package:devel_app/screens/podcasts_screen.dart';
import 'package:devel_app/screens/readings_screen.dart';
import 'package:devel_app/screens/todo_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              color: Colors.white,
              height: 120,
              width: double.infinity,
              // padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Image.asset(
                  "assets/images/logo.jpg",
                  fit: BoxFit.cover,
                  height: 100,
                ),
              )
              // Text(
              //   "Menyu",
              //   style: TextStyle(
              //       fontWeight: FontWeight.w900,
              //       fontSize: 30,
              //       color: Theme.of(context).primaryColor),
              // ),
              ),
          SizedBox(
            height: 20,
          ),
          buildListTile("Bosh Sahifa", Icons.home, () {
            Navigator.of(context).pushReplacementNamed("/");
          }),
          buildListTile("Maqolalar", Icons.article, () {
            Navigator.of(context).pushReplacementNamed(ReadingsScreen.routeName,
                arguments: {"isBook": false});
          }),
          buildListTile("Kitoblar", Icons.book, () {
            Navigator.of(context).pushReplacementNamed(ReadingsScreen.routeName,
                arguments: {"isBook": true});
          }),
          buildListTile("Podcastlar", Icons.mic, () {
            Navigator.of(context)
                .pushReplacementNamed(PodcastsScreen.routeName);
          }),
          buildListTile("Todo", Icons.check, () {
            Navigator.of(context).pushReplacementNamed(TodoScreen.routeName);
          }),
        ],
      ),
    );
  }
}

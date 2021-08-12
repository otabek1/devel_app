import 'package:devel_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = "/contact";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Bog'lanish"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                "assets/images/logo.jpg",
                height: (MediaQuery.of(context).size.height * .3),
                width: MediaQuery.of(context).size.width - 55,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("+998931323342"),
                        onTap: () async {
                          await launch("tel: +998931323342");
                        },
                      ),
                    ),
                    Container(
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.instagram),
                        title: Text("https://instagram.com/develapp.uz"),
                        onTap: () async {
                          await launch("https://instagram.com/develapp.uz");
                        },
                      ),
                    ),
                    Container(
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.telegram),
                        title: Text("https://t.me/DevelApp"),
                        onTap: () async {
                          await launch("https://t.me/DevelApp");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/devellapp.appspot.com/o/reklama.png?alt=media&token=d99baa92-a9dd-480a-aed1-31ed519d74ff",
              fit: BoxFit.fill,
              height: 100,

              // width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}

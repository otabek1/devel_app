import 'package:devel_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 25,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.white,
        child: Container(
          height: 500,
          width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 50,
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    size: 50,
                    color: Colors.black,
                  ),
                  title: Text("Salom"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

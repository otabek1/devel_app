import 'package:devel_app/screens/podcasts_screen.dart';
import 'package:devel_app/screens/readings_screen.dart';
import 'package:devel_app/screens/todo_screen.dart';
import 'package:devel_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devel App"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .7,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ReadingsScreen.routeName,
                            arguments: {"isBook": false});
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Theme.of(context).primaryColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Text(
                                'Maqolalar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ReadingsScreen.routeName,
                            arguments: {"isBook": true});
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Theme.of(context).primaryColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Text(
                                'Kitoblar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // fontFamily: 'Poppins',
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PodcastsScreen.routeName);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Theme.of(context).primaryColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Text(
                                'Podkastlar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // fontFamily: 'Poppins',
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("todo pressed");
                        Navigator.of(context).pushNamed(TodoScreen.routeName);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Theme.of(context).primaryColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Text(
                                'ToDo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // fontFamily: 'Poppins',
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 5,
            shadowColor: Colors.black,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/develapp-f407e.appspot.com/o/ads%2Freklama.png?alt=media&token=1cffad5e-d7fe-4f6b-8618-ebbee94c021a",
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.1,

              // width: MediaQuery.of(context).size.width,
            ),
          )
        ],
      ),
    );
  }
}

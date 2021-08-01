import 'package:devel_app/screens/podcasts_screen.dart';
import 'package:devel_app/screens/readings_screen.dart';
import 'package:flutter/material.dart';


class TabsScreen extends StatefulWidget {


  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Widget> _pages;
  @override
  void initState() {
    // _pages = [ReadingsScreen(false), ReadingsScreen(true), PodcastsScreen()];
    super.initState();
  }

  int _selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DevelApp"),
        ),
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Maqolalar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Kitoblar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Podkastlar"),
          ],
        ));
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}

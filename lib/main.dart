import 'package:devel_app/providers/readings.dart';
import 'package:devel_app/screens/articles_screen.dart';
import 'package:devel_app/screens/readings_screen.dart';
import 'package:devel_app/screens/pdf_viewer.dart';
import 'package:devel_app/screens/read_article_screen.dart';
import 'package:devel_app/screens/tabs_screen.dart';
import 'package:devel_app/utils/material_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Loading"),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    print("MyApp");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Readings()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: createMaterialColor(Color.fromRGBO(43, 49, 77, 1)),
        ),
        home: TabsScreen(),
        routes: {
          ArticlesScreen.routeName: (_) => ArticlesScreen(),
          ReadArticleScreen.routeName: (_) => ReadArticleScreen(),
          PdfViewerScreen.routeName: (_) => PdfViewerScreen(),
        },
      ),
    );
  }
}

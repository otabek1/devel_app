import 'package:devel_app/providers/articles.dart';
import 'package:devel_app/screens/read_article_screen.dart';
import 'package:devel_app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlesScreen extends StatelessWidget {
  static const routeName = "/articles";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // print("AScrenn");

    var articles = Provider.of<Articles>(context).articles();

    return Scaffold(
      appBar: AppBar(
        title: Text("Maqolalar"),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (ctx, index) {
              var currentArticle = articles[index];
              return Text("ss");
              //     Navigator.of(context).pushNamed(ReadArticleScreen.routeName,
              //         arguments: articles[index].id);
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //     margin:
              //         EdgeInsets.only(bottom: 16, left: 5, right: 5, top: 1),
              //     width: size.width - 48,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(38.5),
              //       boxShadow: [
              //         BoxShadow(
              //           offset: Offset(0, 10),
              //           blurRadius: 33,
              //           color: Color(0xFFD3D3D3).withOpacity(.8),
              //         ),
              //       ],
              //     ),
              //     child: ListTile(
              //       title: Text(
              //         articles[index].title,
              //         maxLines: 2,
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color(0xFF393939),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),

              //       subtitle: Container(
              //         margin: const EdgeInsets.only(top: 10),
              //         child: Text(
              //           articles[index].author,
              //           style: TextStyle(color: Color(0xFF8F8F8F)),
              //         ),
              //       ),
              //       // Spacer(),
              //       trailing: IconButton(
              //         icon: Icon(
              //           Icons.arrow_forward_ios,
              //           size: 18,
              //         ),
              //         onPressed: () {
              //           Navigator.of(context).pushNamed(
              //               ReadArticleScreen.routeName,
              //               arguments: articles[index].id);
              //         },
              //       ),
              //     ),
              //   ),
              // );
            }),
      ),
    );
  }
}

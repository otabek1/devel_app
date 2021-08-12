import 'package:devel_app/providers/readings.dart';
import 'package:devel_app/widgets/drawer.dart';
import 'package:devel_app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadingsScreen extends StatelessWidget {
  static const routeName = "/readings";
  var readings;
  var body;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Readings>(context).readings,
        builder: (BuildContext context, AsyncSnapshot<List<Reading>> data) {
          print("got data ${data.data}");
          var arguments =
              ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
          final isBook = arguments["isBook"];
          if (data.hasError) {
            print(" error >> ${data.error.toString()}");
            body = Center(
              child:
                  Text("Qandaydir xatolik yuz berdi. Qaytdan urinib ko'ring"),
            );
          } else if (data.hasData) {
            if (data.data != null) {
              print("data is not null ${data.data}");
              if (isBook!) {
                readings =
                    data.data!.where((element) => element.isBook == 1).toList();
              } else {
                readings =
                    data.data!.where((element) => element.isBook == 0).toList();
              }
              body = Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.70,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: ListView.builder(
                        itemCount: readings.length,
                        itemBuilder: (ctx, index) {
                          return ListItem(
                            context,
                            readings[index],
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
                  ]);
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
              title: isBook! ? Text("Kitoblar") : Text("Maqolalar"),
            ),
            drawer: MainDrawer(),
            body: body,
          );
        });
  }
}

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
            if (isBook!) {
              readings =
                  data.data!.where((element) => element.isBook == 1).toList();
            } else {
              readings =
                  data.data!.where((element) => element.isBook == 0).toList();
            }
            body = Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
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
              title: isBook! ? Text("Kitoblar") : Text("Maqolalar"),
            ),
            drawer: MainDrawer(),
            body: body,
          );
        });
  }
}

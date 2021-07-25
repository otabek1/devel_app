import 'package:devel_app/api/pdf_api.dart';
import 'package:devel_app/providers/readings.dart';
import 'package:devel_app/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget ListItem(BuildContext context, Reading reading) {
  var size = MediaQuery.of(context).size;
  var file;
  return GestureDetector(
    onTap: () async {
      print("PATH=== ${reading.path}");
      if (reading.path.isEmpty) {
        print("EMPTY >>>>");
        file = await PDFApi.loadNetwork(reading.url, reading.title);
        print("file path >>>> ${file.path}");
        Provider.of<Readings>(context, listen: false)
            .addReadingPath(reading.id, file.path);
      }
      print("navigator before");
      if (file == null) {
        Navigator.of(context).pushNamed(PdfViewerScreen.routeName, arguments: {
          "title": reading.title,
          "path": reading.path,
          "file": null
        });
      } else {
        Navigator.of(context).pushNamed(PdfViewerScreen.routeName, arguments: {
          "title": reading.title,
          "path": null,
          "file": file,
        });
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.only(bottom: 16, left: 5, right: 5, top: 1),
      width: size.width - 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.8),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          reading.title,
          maxLines: 2,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF393939),
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            reading.author,
            style: TextStyle(color: Color(0xFF8F8F8F)),
          ),
        ),
        // Spacer(),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
          onPressed: () async {
            print("PATH=== $reading.path");
            if (reading.path.isEmpty) {
              print("EMPTY >>>>");
              final file = await PDFApi.loadNetwork(reading.url, reading.title);
              print("file path >>>> ${file.path}");
              Provider.of<Readings>(context, listen: false)
                  .addReadingPath(reading.id, file.path);
            }
            Navigator.of(context).pushNamed(PdfViewerScreen.routeName,
                arguments: {"title": reading.title, "path": reading.path});
          },
        ),
      ),
    ),
  );
}
